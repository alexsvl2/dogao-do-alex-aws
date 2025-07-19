# migracao_mesas.py

from app import create_app, db

app = create_app()

def rodar_migracao():
    with app.app_context():
        print("--- INICIANDO MIGRAÇÃO PARA ADICIONAR MESAS ---")
        
        # Primeiro, cria todas as tabelas que possam estar faltando (como 'delivery_mesas')
        # É seguro rodar, não apaga nada.
        print("Passo 1: Garantindo que todas as tabelas existem...")
        db.create_all()
        print("Verificação de tabelas concluída.")
        
        # Comandos SQL para adicionar as colunas que faltam na tabela de pedidos
        comandos = [
            "ALTER TABLE delivery_pedidos ADD COLUMN mesa_id INTEGER",
            "ALTER TABLE delivery_pedidos ADD COLUMN status VARCHAR(20)"
        ]

        for comando in comandos:
            try:
                print(f"Executando: {comando}...")
                db.session.execute(db.text(comando))
                db.session.commit()
                print("--> SUCESSO.")
            except Exception as e:
                print(f"--> AVISO: Comando falhou, provavelmente a coluna já existe. Erro: {e}")
                db.session.rollback()
        
        print("\n--- MIGRAÇÃO CONCLUÍDA ---")

if __name__ == '__main__':
    rodar_migracao()
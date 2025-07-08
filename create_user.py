from app import create_app, db
from app.models import Usuario, Mesa
from werkzeug.security import generate_password_hash

app = create_app()

with app.app_context():
    print("Criando todas as tabelas...")
    db.create_all()
    print("Tabelas criadas (ou já existentes).")
    
    if Usuario.query.filter_by(username='admin').first() is None:
        print("Criando usuário 'admin'...")
        hashed_password = generate_password_hash('senha123')
        novo_usuario = Usuario(username='admin', password_hash=hashed_password)
        db.session.add(novo_usuario)
        db.session.commit()
        print("Usuário 'admin' criado com sucesso!")
    else:
        print("Usuário 'admin' já existe.")

    if Mesa.query.count() == 0:
        print("Criando mesas iniciais (1 a 4)...")
        for i in range(1, 5):
            nova_mesa = Mesa(numero=i)
            db.session.add(nova_mesa)
        db.session.commit()
        print("Mesas criadas.")
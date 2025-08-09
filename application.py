# application.py

from app import create_app

# A variável precisa se chamar 'application' para que o servidor Gunicorn
# a encontre por padrão, conforme a configuração que faremos no Render.
application = create_app()


# Este bloco abaixo serve para que você possa rodar a aplicação
# localmente no seu computador para testes com o comando 'python application.py'
if __name__ == '__main__':
    application.run(debug=True)
# app/__init__.py (VERSÃO FINAL E CORRIGIDA)

import os
from flask import Flask
from flask_login import LoginManager
from .models import db, Usuario
from dotenv import load_dotenv

load_dotenv()

def create_app():
    # A MUDANÇA CRUCIAL ESTÁ AQUI:
    # Esta linha garante que o Flask encontre a pasta 'static' que está dentro de 'app'
    app = Flask(__name__, static_folder='static', static_url_path='/static')
    
    app.config['SECRET_KEY'] = os.getenv('SECRET_KEY', 'uma-chave-padrao-de-seguranca')
    app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URL')
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    db.init_app(app)
    
    login_manager = LoginManager()
    login_manager.init_app(app)
    login_manager.login_view = 'auth.login'
    
    @login_manager.user_loader
    def load_user(user_id):
        return db.session.get(Usuario, int(user_id))

    # Registro dos Blueprints
    from .auth.routes import auth_bp
    app.register_blueprint(auth_bp)

    from .pedidos.routes import pedidos_bp
    app.register_blueprint(pedidos_bp, url_prefix='/pedidos')

    from .caixa.routes import caixa_bp
    app.register_blueprint(caixa_bp, url_prefix='/caixa')
    
    return app
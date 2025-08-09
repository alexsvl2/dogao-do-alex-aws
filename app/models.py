# app/models.py

from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin
from werkzeug.security import check_password_hash, generate_password_hash
from datetime import datetime, date

# Criamos a instância do SQLAlchemy aqui, mas sem associá-la a um app ainda.
# Isso será feito no __init__.py.
db = SQLAlchemy()

# --- MODELO UNIFICADO DE USUÁRIO ---

class Usuario(UserMixin, db.Model):
    """Modelo para o usuário do sistema (login para ambos os sistemas)."""
    __tablename__ = 'delivery_usuarios'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, nullable=False)
    password_hash = db.Column(db.String(255), nullable=False)

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password): 
        return check_password_hash(self.password_hash, password)

# --- MODELOS DO SISTEMA DE PEDIDOS ---

class Cliente(db.Model):
    """Modelo para os clientes cadastrados."""
    __tablename__ = 'delivery_clientes'
    id = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(100), nullable=False, unique=True)
    telefone = db.Column(db.String(20), nullable=True)
    endereco = db.Column(db.Text, nullable=True)
    bairro = db.Column(db.String(100), nullable=True)
    pedidos = db.relationship('Pedido', backref='cliente', lazy=True)

class Produto(db.Model):
    """Modelo para os produtos cadastrados."""
    __tablename__ = 'delivery_produtos'
    id = db.Column(db.Integer, primary_key=True)
    descricao = db.Column(db.String(200), nullable=False, unique=True)
    valor = db.Column(db.Numeric(10, 2), nullable=False)

class Pedido(db.Model):
    """Modelo para o cabeçalho de um pedido."""
    __tablename__ = 'delivery_pedidos'
    id = db.Column(db.Integer, primary_key=True)
    cliente_id = db.Column(db.Integer, db.ForeignKey('delivery_clientes.id'), nullable=False)
    nome_cliente = db.Column(db.String(100), nullable=False)
    tipo_pedido = db.Column(db.String(20), nullable=False)
    valor_entrega = db.Column(db.Numeric(10, 2), default=0.0)
    valor_total = db.Column(db.Numeric(10, 2), nullable=False)
    data_pedido = db.Column(db.DateTime, default=datetime.utcnow)
    itens = db.relationship('ItemPedido', backref='pedido', lazy=True, cascade="all, delete-orphan")

class ItemPedido(db.Model):
    """Modelo para cada item dentro de um pedido."""
    __tablename__ = 'delivery_itens_pedido'
    id = db.Column(db.Integer, primary_key=True)
    pedido_id = db.Column(db.Integer, db.ForeignKey('delivery_pedidos.id'), nullable=False)
    produto_id = db.Column(db.Integer, db.ForeignKey('delivery_produtos.id'), nullable=False)
    produto_descricao = db.Column(db.String(200), nullable=False)
    valor_unitario = db.Column(db.Numeric(10, 2), nullable=False)
    quantidade = db.Column(db.Integer, nullable=False)


# --- MODELOS DO FLUXO DE CAIXA ---

class Transacao(db.Model):
    """Modelo para as transações do fluxo de caixa."""
    __tablename__ = 'transacoes' # Mantive o nome original da sua tabela
    id = db.Column(db.Integer, primary_key=True)
    data_transacao = db.Column(db.Date, nullable=False, default=date.today)
    tipo = db.Column(db.String(10), nullable=False) # 'entrada', 'saida', 'fiado'
    descricao = db.Column(db.String(200), nullable=False)
    # Alterado de Float para Numeric para maior precisão com valores monetários
    valor = db.Column(db.Numeric(10, 2), nullable=False)
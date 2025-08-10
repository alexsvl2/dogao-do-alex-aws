from flask import Blueprint, render_template, request, redirect, url_for, flash
from flask_login import login_required
from app import db
from app.models import Caixa
from datetime import datetime, timedelta
from sqlalchemy import func
import pytz

caixa_bp = Blueprint('caixa', __name__, template_folder='templates')

@caixa_bp.route('/')
@login_required
def index():
    # Lógica para obter o status atual do caixa
    saldo_atual = db.session.query(func.sum(Caixa.valor)).scalar() or 0.0
    return render_template('caixa/index.html', saldo_atual=saldo_atual)

@caixa_bp.route('/lancamento', methods=['POST'])
@login_required
def lancamento():
    tipo = request.form.get('tipo')
    valor = float(request.form.get('valor'))
    descricao = request.form.get('descricao')
    forma_pagamento = request.form.get('forma_pagamento')

    if tipo == 'saida':
        valor = -valor

    fuso_horario_sp = pytz.timezone('America/Sao_Paulo')
    data_atual_sp = datetime.now(fuso_horario_sp)


    novo_lancamento = Caixa(
        tipo=tipo, 
        valor=valor, 
        descricao=descricao, 
        forma_pagamento=forma_pagamento,
        data=data_atual_sp
    )
    db.session.add(novo_lancamento)
    db.session.commit()

    flash('Lançamento adicionado com sucesso!', 'success')
    return redirect(url_for('caixa.index'))

@caixa_bp.route('/extrato')
@login_required
def extrato():
    data_inicio_str = request.args.get('data_inicio')
    data_fim_str = request.args.get('data_fim')
    periodo = request.args.get('periodo')
    
    query = Caixa.query
    fuso_horario_sp = pytz.timezone('America/Sao_Paulo')
    hoje = datetime.now(fuso_horario_sp).date()
    titulo_periodo = "Todos os Lançamentos"

    if data_inicio_str and data_fim_str:
        try:
            data_inicio = datetime.strptime(data_inicio_str, '%Y-%m-%d').date()
            data_fim = datetime.strptime(data_fim_str, '%Y-%m-%d').date()
            
            # Para incluir o dia final inteiro, ajustamos a data para o final do dia
            data_fim_dt = datetime.combine(data_fim, datetime.max.time())
            
            # Converte as datas para o fuso horário correto antes de filtrar
            data_inicio_dt_tz = fuso_horario_sp.localize(datetime.combine(data_inicio, datetime.min.time()))
            data_fim_dt_tz = fuso_horario_sp.localize(data_fim_dt)

            query = query.filter(Caixa.data.between(data_inicio_dt_tz, data_fim_dt_tz))
            titulo_periodo = f"de {data_inicio.strftime('%d/%m/%Y')} a {data_fim.strftime('%d/%m/%Y')}"
        except ValueError:
            flash('Formato de data inválido. Use AAAA-MM-DD.', 'danger')
            return redirect(url_for('caixa.extrato'))
    elif periodo:
        if periodo == 'hoje':
            start_of_day = fuso_horario_sp.localize(datetime.combine(hoje, datetime.min.time()))
            end_of_day = fuso_horario_sp.localize(datetime.combine(hoje, datetime.max.time()))
            query = query.filter(Caixa.data.between(start_of_day, end_of_day))
            titulo_periodo = "Hoje"
        elif periodo == 'ontem':
            ontem = hoje - timedelta(days=1)
            start_of_day = fuso_horario_sp.localize(datetime.combine(ontem, datetime.min.time()))
            end_of_day = fuso_horario_sp.localize(datetime.combine(ontem, datetime.max.time()))
            query = query.filter(Caixa.data.between(start_of_day, end_of_day))
            titulo_periodo = "Ontem"
        elif periodo == '7dias':
            sete_dias_atras = hoje - timedelta(days=6)
            start_of_day = fuso_horario_sp.localize(datetime.combine(sete_dias_atras, datetime.min.time()))
            end_of_day = fuso_horario_sp.localize(datetime.combine(hoje, datetime.max.time()))
            query = query.filter(Caixa.data.between(start_of_day, end_of_day))
            titulo_periodo = "Últimos 7 dias"
        elif periodo == '30dias':
            trinta_dias_atras = hoje - timedelta(days=29)
            start_of_day = fuso_horario_sp.localize(datetime.combine(trinta_dias_atras, datetime.min.time()))
            end_of_day = fuso_horario_sp.localize(datetime.combine(hoje, datetime.max.time()))
            query = query.filter(Caixa.data.between(start_of_day, end_of_day))
            titulo_periodo = "Últimos 30 dias"
    else:
        # Se nenhum filtro for aplicado, exibe o de hoje por padrão
        start_of_day = fuso_horario_sp.localize(datetime.combine(hoje, datetime.min.time()))
        end_of_day = fuso_horario_sp.localize(datetime.combine(hoje, datetime.max.time()))
        query = query.filter(Caixa.data.between(start_of_day, end_of_day))
        titulo_periodo = "Hoje"


    movimentacoes = query.order_by(Caixa.data.desc()).all()

    total_entradas = sum(mov.valor for mov in movimentacoes if mov.tipo == 'entrada')
    total_saidas = abs(sum(mov.valor for mov in movimentacoes if mov.tipo == 'saida'))
    saldo = total_entradas - total_saidas

    return render_template('caixa/extrato.html', 
                           movimentacoes=movimentacoes, 
                           total_entradas=total_entradas,
                           total_saidas=total_saidas,
                           saldo=saldo,
                           titulo_periodo=titulo_periodo,
                           data_inicio=data_inicio_str,
                           data_fim=data_fim_str)

@caixa_bp.route('/edit/<int:id>', methods=['GET', 'POST'])
@login_required
def edit(id):
    lancamento = Caixa.query.get_or_404(id)
    if request.method == 'POST':
        tipo = request.form.get('tipo')
        valor = float(request.form.get('valor'))
        
        lancamento.descricao = request.form.get('descricao')
        lancamento.forma_pagamento = request.form.get('forma_pagamento')
        
        # Ajusta o valor para negativo se for saída, e positivo se for entrada
        lancamento.valor = abs(valor) if tipo == 'entrada' else -abs(valor)
        lancamento.tipo = tipo

        db.session.commit()
        flash('Lançamento atualizado com sucesso!', 'success')
        return redirect(url_for('caixa.extrato'))
    return render_template('caixa/edit.html', lancamento=lancamento)

@caixa_bp.route('/delete/<int:id>', methods=['POST'])
@login_required
def delete(id):
    lancamento = Caixa.query.get_or_404(id)
    db.session.delete(lancamento)
    db.session.commit()
    flash('Lançamento excluído com sucesso!', 'success')
    return redirect(url_for('caixa.extrato'))

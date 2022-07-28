# Arquivo contendo utilitário criado para suportar os testes
# Ex.: O Fix aqui implementado que cria um valor randômico hash para ser usado na geração
# dos screenshots que vão compor o relatório

from faker import Faker
fake = Faker(['pt_BR'])

# Fix #2 para o relatório conter os screenshots quando executado em paralelo


def screenshot_name():
    return fake.sha1()

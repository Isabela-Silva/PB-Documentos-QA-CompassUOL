import pytest
from src.Calculadora import Calculadora

def test_soma():
    calc = Calculadora()
    resultado = calc.soma(2, 3)
    assert resultado == 5

def test_subtracao():
    calc = Calculadora()
    assert calc.subtracao(5, 3) == 2
    assert calc.subtracao(0, 10) == -10

def test_multiplicacao():
    calc = Calculadora()
    assert calc.multiplicacao(2, 3) == 6
    assert calc.multiplicacao(-1, 3) == -3

def test_divisao():
    calc = Calculadora()
    assert calc.divisao(10, 2) == 5
    assert calc.divisao(5, 2) == 2.5

def test_divisao_por_zero():
    calc = Calculadora()
    with pytest.raises(ZeroDivisionError):
        calc.divisao(10, 0)
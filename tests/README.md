# Tests

## Propósito

Este diretório contém todos os testes automatizados para garantir a qualidade e confiabilidade dos códigos do projeto Advanced Statistical Analysis R.

## Estrutura

```
tests/
├── unit/                   # Testes unitários
│   ├── test_functions.R    # Testes das funções estatísticas
│   ├── test_preprocessing.R # Testes de pré-processamento
│   └── test_models.R       # Testes dos modelos
├── integration/            # Testes de integração
│   ├── test_workflows.R    # Testes de fluxos completos
│   └── test_shiny_apps.R   # Testes das aplicações Shiny
├── data/                   # Dados de teste
│   ├── sample_data.csv     # Dados de exemplo para testes
│   └── test_datasets.R     # Datasets simulados
└── README.md               # Este arquivo
```

## Exemplos de Conteúdo Futuro

### Testes Unitários
- Validação de funções estatísticas customizadas
- Testes de robustez para análise multivariada
- Verificação de pressupostos estatísticos
- Testes de performance para grandes datasets

### Testes de Integração
- Fluxos completos de análise de dados
- Integração entre módulos estatísticos
- Testes de aplicações Shiny
- Validação de outputs e relatórios

### Dados de Teste
- Datasets sintéticos com propriedades conhecidas
- Casos extremos e edge cases
- Dados com missings e outliers
- Diferentes estruturas de dados (temporal, categórica, etc.)

## Como Executar os Testes

```r
# Instalar pacote de testes
install.packages("testthat")

# Executar todos os testes
testthat::test_dir("tests/")

# Executar testes específicos
testthat::test_file("tests/unit/test_functions.R")
```

## Convenções

- Nomear arquivos de teste com prefixo `test_`
- Usar descrições claras para cada teste
- Incluir casos de sucesso e falha
- Documentar dados de teste utilizados
- Manter testes independentes entre si

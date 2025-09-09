# Tests / Testes

*[English](#english) | [Português](#português)*

---

## English

### Purpose
This directory contains all automated tests to ensure quality and reliability of the Advanced Statistical Analysis R project code.

### Structure
```
tests/
├── unit/                   # Unit tests
│   ├── test_functions.R    # Statistical functions tests
│   ├── test_preprocessing.R # Data preprocessing tests
│   └── test_models.R       # Statistical models tests
├── integration/            # Integration tests
│   ├── test_workflows.R    # Complete workflow tests
│   └── test_shiny_apps.R   # Shiny applications tests
├── data/                   # Test data
│   ├── sample_data.csv     # Sample data for testing
│   └── test_datasets.R     # Simulated datasets
└── README.md              # This file
```

### Testing Framework
We use the **testthat** package, which is the standard R testing framework.

#### Basic testthat Pattern
```r
library(testthat)
library(yourpackage)

# Test structure
test_that("descriptive test name", {
  # Arrange
  input_data <- data.frame(x = 1:10, y = 1:10)
  expected_result <- 2
  
  # Act
  result <- your_function(input_data)
  
  # Assert
  expect_equal(result, expected_result)
  expect_true(is.numeric(result))
  expect_length(result, 1)
})
```

#### Common testthat Expectations
- `expect_equal()` - exact equality
- `expect_true()` / `expect_false()` - boolean values
- `expect_length()` - object length
- `expect_type()` - object type
- `expect_error()` - function throws error
- `expect_warning()` - function produces warning
- `expect_silent()` - function runs without messages

### Running Tests

#### Run All Tests
```r
# From R console
testthat::test_dir("tests/")

# Or using devtools
devtools::test()
```

#### Run Specific Test Categories
```r
# Unit tests only
testthat::test_dir("tests/unit/")

# Integration tests only
testthat::test_dir("tests/integration/")

# Specific test file
testthat::test_file("tests/unit/test_functions.R")
```

#### Command Line Execution
```bash
# Using Rscript
Rscript -e "testthat::test_dir('tests/')"

# Using R CMD check (full package check)
R CMD check .
```

### Test Organization Guidelines

#### Unit Tests (`tests/unit/`)
- Test individual functions in isolation
- Mock external dependencies
- Fast execution (< 1 second per test)
- Focus on edge cases and error conditions

#### Integration Tests (`tests/integration/`)
- Test component interactions
- Use real data when possible
- Test complete workflows
- May take longer to execute

#### Test Data (`tests/data/`)
- Small, representative datasets
- Synthetic data to avoid privacy issues
- Documented data generation process

### Incremental Collaboration

#### Before Contributing
1. **Run existing tests**: Ensure all current tests pass
   ```r
   testthat::test_dir("tests/")
   ```

2. **Write tests first**: Follow Test-Driven Development (TDD)
   - Write failing test for new functionality
   - Implement minimum code to pass test
   - Refactor while keeping tests green

#### Contributing New Tests
1. **Name tests descriptively**:
   ```r
   test_that("linear_regression handles missing values correctly", { ... })
   ```

2. **One concept per test**: Keep tests focused and atomic

3. **Use meaningful test data**: Avoid magic numbers, use descriptive variables

4. **Test both success and failure paths**:
   ```r
   test_that("function validates input parameters", {
     expect_error(my_function("invalid_input"))
     expect_silent(my_function(valid_input))
   })
   ```

#### Code Coverage
- Aim for >80% code coverage
- Check coverage with:
   ```r
   covr::package_coverage()
   ```

#### Continuous Integration
- All tests must pass before merging
- Add tests for bug fixes to prevent regression
- Document any test dependencies or setup requirements

---

## Português

### Propósito
Este diretório contém todos os testes automatizados para garantir a qualidade e confiabilidade dos códigos do projeto Advanced Statistical Analysis R.

### Estrutura
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
└── README.md              # Este arquivo
```

### Framework de Testes
Utilizamos o pacote **testthat**, que é o framework padrão para testes em R.

#### Padrão Básico do testthat
```r
library(testthat)
library(yourpackage)

# Estrutura do teste
test_that("nome descritivo do teste", {
  # Preparar (Arrange)
  dados_entrada <- data.frame(x = 1:10, y = 1:10)
  resultado_esperado <- 2
  
  # Executar (Act)
  resultado <- sua_funcao(dados_entrada)
  
  # Verificar (Assert)
  expect_equal(resultado, resultado_esperado)
  expect_true(is.numeric(resultado))
  expect_length(resultado, 1)
})
```

#### Expectativas Comuns do testthat
- `expect_equal()` - igualdade exata
- `expect_true()` / `expect_false()` - valores booleanos
- `expect_length()` - comprimento do objeto
- `expect_type()` - tipo do objeto
- `expect_error()` - função gera erro
- `expect_warning()` - função produz aviso
- `expect_silent()` - função executa sem mensagens

### Executando Testes

#### Executar Todos os Testes
```r
# Do console R
testthat::test_dir("tests/")

# Ou usando devtools
devtools::test()
```

#### Executar Categorias Específicas de Testes
```r
# Apenas testes unitários
testthat::test_dir("tests/unit/")

# Apenas testes de integração
testthat::test_dir("tests/integration/")

# Arquivo de teste específico
testthat::test_file("tests/unit/test_functions.R")
```

#### Execução via Linha de Comando
```bash
# Usando Rscript
Rscript -e "testthat::test_dir('tests/')"

# Usando R CMD check (verificação completa do pacote)
R CMD check .
```

### Diretrizes de Organização dos Testes

#### Testes Unitários (`tests/unit/`)
- Testar funções individuais isoladamente
- Simular dependências externas
- Execução rápida (< 1 segundo por teste)
- Focar em casos extremos e condições de erro

#### Testes de Integração (`tests/integration/`)
- Testar interações entre componentes
- Usar dados reais quando possível
- Testar fluxos de trabalho completos
- Podem demorar mais para executar

#### Dados de Teste (`tests/data/`)
- Datasets pequenos e representativos
- Dados sintéticos para evitar questões de privacidade
- Processo de geração de dados documentado

### Colaboração Incremental

#### Antes de Contribuir
1. **Execute os testes existentes**: Garanta que todos os testes atuais passem
   ```r
   testthat::test_dir("tests/")
   ```

2. **Escreva testes primeiro**: Siga o Desenvolvimento Orientado por Testes (TDD)
   - Escreva teste que falha para nova funcionalidade
   - Implemente código mínimo para passar no teste
   - Refatore mantendo os testes funcionando

#### Contribuindo com Novos Testes
1. **Nomeie testes descritivamente**:
   ```r
   test_that("regressao_linear trata valores ausentes corretamente", { ... })
   ```

2. **Um conceito por teste**: Mantenha testes focados e atômicos

3. **Use dados de teste significativos**: Evite números mágicos, use variáveis descritivas

4. **Teste caminhos de sucesso e falha**:
   ```r
   test_that("funcao valida parametros de entrada", {
     expect_error(minha_funcao("entrada_invalida"))
     expect_silent(minha_funcao(entrada_valida))
   })
   ```

#### Cobertura de Código
- Objetive >80% de cobertura de código
- Verifique cobertura com:
   ```r
   covr::package_coverage()
   ```

#### Integração Contínua
- Todos os testes devem passar antes do merge
- Adicione testes para correções de bugs para prevenir regressão
- Documente dependências ou requisitos de configuração dos testes

# Contributing to Advanced Statistical Analysis R

🌍 [English](#english) | [Português](#português)

## English

### 🤝 Welcome Contributors!

We're excited to have you contribute to the Advanced Statistical Analysis R project! This guide will help you understand how to contribute effectively to our statistical computing platform.

### 📋 Table of Contents

- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Code Standards](#code-standards)
- [Testing Guidelines](#testing-guidelines)
- [Documentation](#documentation)
- [Submitting Changes](#submitting-changes)
- [Community Guidelines](#community-guidelines)

### 🚀 Getting Started

#### Prerequisites

- R 4.3+ installed
- RStudio (recommended)
- Git configured
- Basic knowledge of statistical methods
- Familiarity with R package development

#### Development Setup

1. **Fork and Clone**
   ```bash
   git clone https://github.com/yourusername/Advanced-Statistical-Analysis-R.git
   cd Advanced-Statistical-Analysis-R
   ```

2. **Install Dependencies**
   ```r
   # Run the requirements script
   source("requirements.R")
   ```

3. **Create Development Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

### 🔄 Development Workflow

#### Branch Naming Convention

- `feature/description` - New features
- `bugfix/description` - Bug fixes
- `docs/description` - Documentation updates
- `test/description` - Test additions/improvements
- `refactor/description` - Code refactoring

#### Commit Message Format

```
type(scope): brief description

Detailed description (optional)

Fixes #issue_number (if applicable)
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `test`: Testing
- `refactor`: Code refactoring
- `style`: Code style changes
- `perf`: Performance improvements

### 📝 Code Standards

#### R Code Style

1. **Naming Conventions**
   - Functions: `snake_case` (e.g., `calculate_pca_variance`)
   - Variables: `snake_case` (e.g., `data_matrix`)
   - Constants: `UPPER_SNAKE_CASE` (e.g., `MAX_ITERATIONS`)
   - Files: `snake_case.R` (e.g., `statistical_analysis.R`)

2. **Function Documentation**
   ```r
   #' Perform Principal Component Analysis
   #'
   #' @param data Numeric matrix or data frame
   #' @param scale Logical, whether to scale variables
   #' @param center Logical, whether to center variables
   #' @return List containing PCA results
   #' @export
   #' @examples
   #' result <- perform_pca(mtcars, scale = TRUE)
   perform_pca <- function(data, scale = TRUE, center = TRUE) {
     # Function implementation
   }
   ```

3. **Code Structure**
   - Maximum line length: 80 characters
   - Use 2 spaces for indentation
   - Add blank lines between logical sections
   - Comment complex algorithms

#### Statistical Analysis Guidelines

1. **Validation**
   - Always validate input parameters
   - Check for missing values
   - Verify distributional assumptions
   - Include appropriate warnings

2. **Reproducibility**
   - Set seeds for random operations
   - Document all parameters
   - Include version information
   - Provide example datasets

3. **Performance**
   - Use vectorized operations
   - Consider memory usage
   - Profile computationally intensive functions
   - Implement parallel processing where beneficial

### 🧪 Testing Guidelines

#### Test Structure

```r
# tests/testthat/test_statistical_functions.R

test_that("PCA analysis returns correct structure", {
  # Arrange
  test_data <- matrix(rnorm(100), ncol = 4)
  
  # Act
  result <- perform_pca(test_data)
  
  # Assert
  expect_type(result, "list")
  expect_true("pca_result" %in% names(result))
  expect_true("variance_explained" %in% names(result))
})

test_that("PCA handles edge cases correctly", {
  # Test with missing values
  data_with_na <- matrix(c(1, 2, NA, 4), ncol = 2)
  expect_error(perform_pca(data_with_na))
  
  # Test with single column
  single_col <- matrix(1:10, ncol = 1)
  expect_error(perform_pca(single_col))
})
```

#### Running Tests

```r
# Run all tests
testthat::test_dir("tests")

# Run specific test file
testthat::test_file("tests/testthat/test_statistical_functions.R")

# Check test coverage
covr::package_coverage()
```

### 📚 Documentation

#### README Updates

- Keep the main README.md bilingual
- Update feature lists when adding new functionality
- Include performance benchmarks for major additions
- Add usage examples for new statistical methods

#### Function Documentation

- Use roxygen2 format
- Include mathematical formulations when relevant
- Provide references to statistical literature
- Add practical examples

#### Vignettes

```r
# Create vignettes for complex workflows
# vignettes/multivariate_analysis.Rmd

---
title: "Advanced Multivariate Analysis"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{Advanced Multivariate Analysis}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---
```

### 📤 Submitting Changes

#### Pull Request Process

1. **Before Submitting**
   - Run all tests: `testthat::test_dir("tests")`
   - Check code style: `styler::style_pkg()`
   - Update documentation: `devtools::document()`
   - Run R CMD check: `devtools::check()`

2. **Pull Request Template**
   ```markdown
   ## Description
   Brief description of changes
   
   ## Type of Change
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Documentation update
   - [ ] Performance improvement
   
   ## Testing
   - [ ] Added tests for new functionality
   - [ ] All existing tests pass
   - [ ] Verified statistical accuracy
   
   ## Statistical Validation
   - [ ] Compared results with established methods
   - [ ] Verified mathematical correctness
   - [ ] Included appropriate references
   ```

3. **Review Process**
   - Code review by maintainers
   - Statistical validation
   - Performance assessment
   - Documentation review

### 👥 Community Guidelines

#### Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn statistical concepts
- Acknowledge contributions

#### Communication

- Use Issues for bug reports and feature requests
- Tag issues with appropriate labels
- Provide reproducible examples
- Be specific about statistical requirements

#### Statistical Discussions

- Reference peer-reviewed literature when possible
- Explain mathematical concepts clearly
- Consider multiple statistical approaches
- Validate results with known benchmarks

---

## Português

### 🤝 Bem-vindos Colaboradores!

Ficamos animados em tê-lo contribuindo para o projeto Advanced Statistical Analysis R! Este guia ajudará você a entender como contribuir efetivamente para nossa plataforma de computação estatística.

### 📋 Índice

- [Começando](#começando)
- [Fluxo de Desenvolvimento](#fluxo-de-desenvolvimento)
- [Padrões de Código](#padrões-de-código)
- [Diretrizes de Testes](#diretrizes-de-testes)
- [Documentação](#documentação-1)
- [Enviando Alterações](#enviando-alterações)
- [Diretrizes da Comunidade](#diretrizes-da-comunidade)

### 🚀 Começando

#### Pré-requisitos

- R 4.3+ instalado
- RStudio (recomendado)
- Git configurado
- Conhecimento básico de métodos estatísticos
- Familiaridade com desenvolvimento de pacotes R

#### Configuração do Desenvolvimento

1. **Fork e Clone**
   ```bash
   git clone https://github.com/seuusuario/Advanced-Statistical-Analysis-R.git
   cd Advanced-Statistical-Analysis-R
   ```

2. **Instalar Dependências**
   ```r
   # Execute o script de requisitos
   source("requirements.R")
   ```

3. **Criar Branch de Desenvolvimento**
   ```bash
   git checkout -b feature/nome-da-sua-funcionalidade
   ```

### 🔄 Fluxo de Desenvolvimento

#### Convenção de Nomes de Branch

- `feature/descricao` - Novas funcionalidades
- `bugfix/descricao` - Correções de bugs
- `docs/descricao` - Atualizações de documentação
- `test/descricao` - Adições/melhorias de testes
- `refactor/descricao` - Refatoração de código

#### Formato de Mensagem de Commit

```
tipo(escopo): descrição breve

Descrição detalhada (opcional)

Corrige #numero_da_issue (se aplicável)
```

### 📝 Padrões de Código

#### Estilo de Código R

1. **Convenções de Nomenclatura**
   - Funções: `snake_case` (ex: `calcular_variancia_pca`)
   - Variáveis: `snake_case` (ex: `matriz_dados`)
   - Constantes: `UPPER_SNAKE_CASE` (ex: `MAX_ITERACOES`)

2. **Documentação de Funções**
   ```r
   #' Realizar Análise de Componentes Principais
   #'
   #' @param dados Matriz numérica ou data frame
   #' @param escalar Lógico, se deve escalar variáveis
   #' @param centralizar Lógico, se deve centralizar variáveis
   #' @return Lista contendo resultados do PCA
   #' @export
   #' @examples
   #' resultado <- realizar_pca(mtcars, escalar = TRUE)
   realizar_pca <- function(dados, escalar = TRUE, centralizar = TRUE) {
     # Implementação da função
   }
   ```

### 🧪 Diretrizes de Testes

#### Executando Testes

```r
# Executar todos os testes
testthat::test_dir("tests")

# Verificar cobertura de testes
covr::package_coverage()
```

### 📚 Documentação

#### Atualizações do README

- Manter o README.md principal bilíngue
- Atualizar listas de funcionalidades ao adicionar nova funcionalidade
- Incluir benchmarks de performance para adições importantes
- Adicionar exemplos de uso para novos métodos estatísticos

### 📤 Enviando Alterações

#### Processo de Pull Request

1. **Antes de Enviar**
   - Executar todos os testes
   - Verificar estilo de código
   - Atualizar documentação
   - Executar verificação R CMD

### 👥 Diretrizes da Comunidade

#### Código de Conduta

- Seja respeitoso e inclusivo
- Foque em feedback construtivo
- Ajude outros a aprender conceitos estatísticos
- Reconheça contribuições

#### Comunicação

- Use Issues para relatórios de bugs e solicitações de funcionalidades
- Marque issues com rótulos apropriados
- Forneça exemplos reproduzíveis
- Seja específico sobre requisitos estatísticos

#### Discussões Estatísticas

- Referencie literatura revisada por pares quando possível
- Explique conceitos matemáticos claramente
- Considere múltiplas abordagens estatísticas
- Valide resultados com benchmarks conhecidos

---

## 🏆 Recognition

Contributors will be acknowledged in:
- README.md contributors section
- Release notes
- Package documentation
- Special recognition for significant contributions

Thank you for helping make Advanced Statistical Analysis R better! 🎉

---

**Gabriel Demetrios Lafis**  
Project Maintainer  
📧 gabrieldemetrios@gmail.com  
🐙 [@galafis](https://github.com/galafis)

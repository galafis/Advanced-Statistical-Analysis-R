# Functions - Advanced Statistical Analysis R

Este diretório contém funções personalizadas desenvolvidas para o projeto de Análise Estatística Avançada em R. As funções estão organizadas por categoria de análise e fornecem implementações otimizadas para métodos estatísticos específicos.

## 📋 Visão Geral

As funções personalizadas expandem as capacidades analíticas do projeto, fornecendo implementações especializadas, otimizações de performance e interfaces simplificadas para métodos estatísticos complexos.

## 📁 Estrutura de Arquivos

```
functions/
├── statistical_tests.R      # Testes estatísticos customizados
├── plotting_functions.R     # Funções de plotagem avançadas
├── utility_functions.R      # Funções auxiliares e utilitárias
├── model_validation.R       # Validação e diagnósticos de modelos
├── data_processing.R        # Processamento e transformação de dados
└── README.md               # Documentação das funções
```

## 🔧 Categorias de Funções

### statistical_tests.R
Implementações de testes estatísticos especializados:
- Testes de normalidade robustos
- Testes não-paramétricos customizados
- Correções para múltiplas comparações
- Testes de homogeneidade de variância
- Bootstrap e métodos de reamostragem

### plotting_functions.R
Funções avançadas de visualização:
- Gráficos diagnósticos automáticos
- Visualizações multivariadas interativas
- Plots de validação de modelos
- Temas customizados para ggplot2
- Funções para exportação de gráficos

### utility_functions.R
Funções auxiliares e utilitárias:
- Manipulação e limpeza de dados
- Cálculos estatísticos especializados
- Funções de conversão de formatos
- Helpers para análise exploratória
- Utilitários para relatórios

### model_validation.R
Validação e diagnósticos de modelos:
- Cross-validation customizada
- Métricas de performance
- Diagnósticos automáticos
- Testes de adequação do modelo
- Análise de resíduos avançada

### data_processing.R
Processamento e transformação:
- Imputação de valores faltantes
- Transformações de variáveis
- Detecção de outliers
- Normalização e padronização
- Feature engineering

## 🚀 Como Usar

### Carregando as Funções
```r
# Carregar todas as funções
source("functions/statistical_tests.R")
source("functions/plotting_functions.R")
source("functions/utility_functions.R")
source("functions/model_validation.R")
source("functions/data_processing.R")

# Ou carregar uma função específica
source("functions/statistical_tests.R")
```

### Exemplo de Uso
```r
# Exemplo: Teste de normalidade robusto
data(iris)
result <- robust_normality_test(iris$Sepal.Length)
print(result)

# Exemplo: Plot diagnóstico automático
model <- lm(Sepal.Length ~ Sepal.Width, data = iris)
auto_diagnostic_plot(model)

# Exemplo: Cross-validation customizada
cv_results <- custom_cross_validation(model, k = 10)
```

## 📊 Principais Funcionalidades

### Testes Estatísticos Robustos
- **robust_normality_test()**: Teste de normalidade com múltiplos métodos
- **bootstrap_confidence_interval()**: Intervalos de confiança via bootstrap
- **permutation_test()**: Testes de permutação personalizados

### Visualizações Avançadas
- **auto_diagnostic_plot()**: Diagnósticos automáticos de modelos
- **multivariate_plot_matrix()**: Matriz de plots multivariados
- **interactive_scatter_matrix()**: Matriz de dispersão interativa

### Validação de Modelos
- **custom_cross_validation()**: Cross-validation personalizada
- **model_performance_metrics()**: Métricas de performance completas
- **residual_analysis()**: Análise abrangente de resíduos

### Processamento de Dados
- **smart_imputation()**: Imputação inteligente de valores faltantes
- **outlier_detection()**: Detecção múltipla de outliers
- **variable_transformation()**: Transformações automáticas

## 🎯 Benefícios

- **Reutilização**: Funções modulares para uso em múltiplos projetos
- **Otimização**: Implementações otimizadas para performance
- **Consistência**: Padronização de análises e visualizações
- **Flexibilidade**: Parâmetros configuráveis para diferentes cenários
- **Documentação**: Código bem documentado com exemplos

## 📈 Exemplos Práticos

### Análise Completa de Dataset
```r
# Carregar funções
source("functions/data_processing.R")
source("functions/statistical_tests.R")
source("functions/plotting_functions.R")

# Processar dados
data_clean <- smart_data_processing(raw_data)

# Análise exploratória
exploratory_summary(data_clean)

# Testes estatísticos
normality_results <- batch_normality_tests(data_clean)

# Visualizações
exploratory_plot_matrix(data_clean)
```

### Pipeline de Modelagem
```r
# Preparação dos dados
processed_data <- data_preprocessing_pipeline(raw_data)

# Ajuste do modelo
model <- fit_statistical_model(formula, processed_data)

# Validação
validation_results <- comprehensive_model_validation(model)

# Visualização dos resultados
model_diagnostic_dashboard(model, validation_results)
```

## 🔍 Documentação Detalhada

Cada arquivo de função contém:
- Documentação Roxygen2 completa
- Exemplos de uso práticos
- Descrição de parâmetros
- Valores de retorno detalhados
- Referências teóricas quando aplicável

## 🤝 Contribuição

Para adicionar novas funções:
1. Escolha o arquivo apropriado por categoria
2. Siga o padrão de documentação existente
3. Inclua testes unitários quando possível
4. Adicione exemplos de uso
5. Atualize esta documentação

## 📚 Dependências

As funções utilizam os seguintes pacotes:
- `ggplot2`: Visualizações
- `dplyr`: Manipulação de dados
- `plotly`: Gráficos interativos
- `car`: Análise de regressão
- `psych`: Estatísticas psicométricas
- `boot`: Bootstrap
- `MASS`: Estatísticas modernas

---

**Nota**: Este diretório é parte integral do projeto Advanced Statistical Analysis R. Para informações sobre o projeto completo, consulte o [README principal](../README.md).

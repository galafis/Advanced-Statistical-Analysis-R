# Shiny Apps - Advanced Statistical Analysis | Aplicações Shiny - Análise Estatística Avançada

[**🇧🇷 Português**](#português) | [**🇺🇸 English**](#english)

---

## 🇧🇷 Português

### Sobre
Este diretório contém uma coleção de aplicações Shiny interativas para análise estatística avançada. Cada aplicação é projetada para fornecer uma interface de fácil utilização para diferentes aspectos da análise estatística e visualização de dados.

### Estrutura Padrão dos Apps Shiny
Cada aplicação Shiny neste repositório segue uma estrutura padrão para facilitar a manutenção e compreensão:

```
app_name/
├── ui.R          # Interface do usuário (frontend)
├── server.R      # Lógica do servidor (backend)
├── global.R      # Configurações globais e carregamento de bibliotecas
├── www/          # Recursos estáticos (CSS, JS, imagens)
│   ├── style.css
│   ├── custom.js
│   └── images/
└── README.md     # Documentação específica do app
```

#### Arquivos Principais:
- **ui.R**: Define a interface do usuário, layout e elementos visuais
- **server.R**: Contém a lógica de processamento e reatividade
- **global.R**: Carrega bibliotecas, dados e variáveis globais compartilhadas
- **www/**: Diretório para arquivos estáticos (CSS, JavaScript, imagens)

### Como Executar as Aplicações

#### Método 1: Via RStudio
```r
# Abra o projeto no RStudio e execute:
shiny::runApp("caminho/para/o/app")
```

#### Método 2: Via linha de comando R
```r
# Navegue até o diretório do app e execute:
setwd("shiny_apps/nome_do_app")
shiny::runApp()
```

#### Método 3: Execução direta
```r
# Execute diretamente com o caminho:
shiny::runApp("shiny_apps/multivariate_explorer/")
```

### Dependências Necessárias
Antes de executar qualquer aplicação, instale as dependências necessárias:

```r
# Pacotes principais
install.packages(c(
  "shiny",
  "shinydashboard",
  "DT",
  "plotly",
  "ggplot2",
  "dplyr",
  "readr",
  "shinyWidgets"
))

# Pacotes específicos por aplicação
# Multivariate Explorer:
install.packages(c("corrplot", "cluster", "factoextra", "FactoMineR"))

# Regression Analyzer:
install.packages(c("car", "broom", "performance", "see"))

# Time Series Dashboard:
install.packages(c("forecast", "xts", "dygraphs", "anomalyDetection"))
```

### Aplicações Disponíveis

#### 📋 [Multivariate Explorer](./multivariate_explorer/)
Ferramenta abrangente para exploração e análise de dados multivariados.

**Principais funcionalidades:**
- Análise de Componentes Principais (PCA)
- Análise de Agrupamento (Clustering)
- Visualizações multidimensionais interativas
- Matriz de correlação e heatmaps
- Análise discriminante

#### 📈 [Regression Analyzer](./regression_analyzer/)
Plataforma completa para análise de regressão linear e diagnósticos de modelo.

**Principais funcionalidades:**
- Modelos de regressão linear simples e múltipla
- Diagnósticos abrangentes de modelo
- Seleção automática de variáveis
- Visualizações interativas de resultados
- Relatórios exportados

#### ⏳ [Time Series Dashboard](./time_series_dashboard/)
Dashboard especializado para análise e modelagem de séries temporais.

**Principais funcionalidades:**
- Visualização de séries temporais interativas
- Decomposição de tendência e sazonalidade
- Modelos de previsão (ARIMA, Holt-Winters)
- Detecção de anomalias
- Dashboard em tempo real

### Documentação Adicional
- Cada aplicação possui sua própria documentação no arquivo `README.md` específico
- Consulte os comentários no código para detalhes técnicos
- Exemplos de uso estão disponíveis nos próprios aplicativos

### Contribuindo
1. **Fork** este repositório
2. **Clone** seu fork localmente
3. Crie uma **branch** para sua feature: `git checkout -b nova-feature`
4. **Desenvolva** seguindo a estrutura padrão descrita acima
5. **Teste** sua aplicação extensivamente
6. **Commit** suas mudanças: `git commit -m "Adiciona nova feature"`
7. **Push** para sua branch: `git push origin nova-feature`
8. Abra um **Pull Request**

### Diretrizes para Expansão
- Siga a estrutura padrão de diretórios e arquivos
- Mantenha o código bem documentado e comentado
- Inclua validação de entrada e tratamento de erros
- Utilize design responsivo com `shinydashboard` ou `bslib`
- Adicione testes unitários quando possível
- Documente novas dependências no README específico

---

## 🇺🇸 English

### About
This directory contains a collection of interactive Shiny applications for advanced statistical analysis. Each application is designed to provide an easy-to-use interface for different aspects of statistical analysis and data visualization.

### Standard Shiny App Structure
Each Shiny application in this repository follows a standard structure to facilitate maintenance and understanding:

```
app_name/
├── ui.R          # User interface (frontend)
├── server.R      # Server logic (backend)
├── global.R      # Global settings and library loading
├── www/          # Static resources (CSS, JS, images)
│   ├── style.css
│   ├── custom.js
│   └── images/
└── README.md     # App-specific documentation
```

#### Main Files:
- **ui.R**: Defines the user interface, layout, and visual elements
- **server.R**: Contains processing logic and reactivity
- **global.R**: Loads libraries, data, and shared global variables
- **www/**: Directory for static files (CSS, JavaScript, images)

### How to Run Applications

#### Method 1: Via RStudio
```r
# Open the project in RStudio and run:
shiny::runApp("path/to/app")
```

#### Method 2: Via R command line
```r
# Navigate to the app directory and run:
setwd("shiny_apps/app_name")
shiny::runApp()
```

#### Method 3: Direct execution
```r
# Run directly with path:
shiny::runApp("shiny_apps/multivariate_explorer/")
```

### Required Dependencies
Before running any application, install the necessary dependencies:

```r
# Core packages
install.packages(c(
  "shiny",
  "shinydashboard",
  "DT",
  "plotly",
  "ggplot2",
  "dplyr",
  "readr",
  "shinyWidgets"
))

# Application-specific packages
# Multivariate Explorer:
install.packages(c("corrplot", "cluster", "factoextra", "FactoMineR"))

# Regression Analyzer:
install.packages(c("car", "broom", "performance", "see"))

# Time Series Dashboard:
install.packages(c("forecast", "xts", "dygraphs", "anomalyDetection"))
```

### Available Applications

#### 📋 [Multivariate Explorer](./multivariate_explorer/)
Comprehensive tool for multivariate data exploration and analysis.

**Key features:**
- Principal Component Analysis (PCA)
- Clustering Analysis
- Interactive multidimensional visualizations
- Correlation matrix and heatmaps
- Discriminant analysis

#### 📈 [Regression Analyzer](./regression_analyzer/)
Complete platform for linear regression analysis and model diagnostics.

**Key features:**
- Simple and multiple linear regression models
- Comprehensive model diagnostics
- Automatic variable selection
- Interactive result visualizations
- Exported reports

#### ⏳ [Time Series Dashboard](./time_series_dashboard/)
Specialized dashboard for time series analysis and modeling.

**Key features:**
- Interactive time series visualization
- Trend and seasonality decomposition
- Forecasting models (ARIMA, Holt-Winters)
- Anomaly detection
- Real-time dashboard

### Additional Documentation
- Each application has its own documentation in the specific `README.md` file
- Check code comments for technical details
- Usage examples are available within the applications themselves

### Contributing
1. **Fork** this repository
2. **Clone** your fork locally
3. Create a **branch** for your feature: `git checkout -b new-feature`
4. **Develop** following the standard structure described above
5. **Test** your application extensively
6. **Commit** your changes: `git commit -m "Add new feature"`
7. **Push** to your branch: `git push origin new-feature`
8. Open a **Pull Request**

### Guidelines for Expansion
- Follow the standard directory and file structure
- Keep code well documented and commented
- Include input validation and error handling
- Use responsive design with `shinydashboard` or `bslib`
- Add unit tests when possible
- Document new dependencies in the specific README

---

## 📞 Support | Suporte

**🇧🇷 Português:** Para dúvidas ou sugestões, abra uma [issue](../../issues) ou contribua com melhorias.

**🇺🇸 English:** For questions or suggestions, open an [issue](../../issues) or contribute with improvements.

---

**License | Licença:** MIT - see [LICENSE](../../LICENSE) file for details

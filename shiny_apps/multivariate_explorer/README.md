# Multivariate Explorer - Shiny App

Aplicação Shiny interativa para exploração de análise multivariada.

## Funcionalidades

### Análise de Componentes Principais (PCA)
- Upload de datasets CSV/Excel
- Visualização interativa de biplots
- Scree plots dinâmicos
- Seleção de componentes principais
- Export de resultados

### Análise Fatorial
- Análise fatorial exploratória
- Rotação de fatores (varimax, promax)
- Matriz de cargas fatoriais
- Teste de adequação (KMO, Bartlett)

### Análise de Agrupamentos
- K-means clustering
- Clustering hierárquico
- Método do cotovelo para k ótimo
- Dendrogramas interativos
- Silhouette analysis

## Arquitetura

```
multivariate_explorer/
├── ui.R                    # Interface do usuário
├── server.R                # Lógica do servidor
├── global.R                # Configurações globais
├── modules/                # Módulos reutilizáveis
│   ├── pca_module.R
│   ├── factor_module.R
│   └── cluster_module.R
├── www/                    # Recursos web
│   ├── styles.css
│   └── scripts.js
└── README.md
```

## Uso

### Execução Local
```r
# Instalar dependências
install.packages(c("shiny", "shinydashboard", "DT", 
                   "plotly", "psych", "cluster", "factoextra"))

# Executar aplicação
shiny::runApp("shiny_apps/multivariate_explorer/")
```

### Deploy
```r
# Deploy no shinyapps.io
rsconnect::deployApp("shiny_apps/multivariate_explorer/")
```

## Requisitos

- R >= 4.0.0
- Pacotes: shiny, shinydashboard, DT, plotly, psych, cluster, factoextra
- Navegador com suporte a JavaScript

## Recursos

- Interface responsiva
- Visualizações interativas com plotly
- Export de gráficos em alta resolução
- Relatórios automatizados
- Suporte a múltiplos formatos de dados

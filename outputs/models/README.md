# Models Directory

Este diretório contém todos os modelos estatísticos treinados e salvos.

## Estrutura

- **regression/**: Modelos de regressão linear e não-linear
- **classification/**: Modelos de classificação
- **clustering/**: Modelos de agrupamento
- **time_series/**: Modelos de séries temporais

## Formatos

- RDS (R nativo)
- Pickle (Python)
- PMML (Portable)
- ONNX (Open Neural Network Exchange)

## Nomeação

`[tipo]_[dataset]_[algoritmo]_[versao].[ext]`

Exemplo: `regression_sales_lm_v1.rds`

# Deploy na AWS


## Requisitos

- Terraform
- AWS CLI

## Como rodar

1. Faça login no aws com `aws login`
2. Rode `terraform init` para baixar os módulos do terraform
3. Rode `terraform plan` para ver o que será feito
4. Rode `terraform apply` para criar os recursos na nuvem
5. Não esqueça de rodar `terraform destroy` no final para deletar os recursos

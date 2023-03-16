# Create sensitive variables using `.tfvars`
```
gitlab_api_token = "<your personal access token for access gitlab permissions>"
gitlab_host_url = "<self hosting gitlab server url>"
```

> 在 `tfvars` 定義好的 variable 也要在 variables 定義一個 {}，參考 [https://developer.hashicorp.com/terraform/language/values/variables#values-for-undeclared-variables](https://developer.hashicorp.com/terraform/language/values/variables#values-for-undeclared-variables)
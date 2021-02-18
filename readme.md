### Instalar o AWS-Cli

Primeiro passo é instalar o CLI da aws:
https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html

### Criar os arquivos de configurações
É necessário criar os arquivos de configuração que AWS-CLI vai utilizar como credencial para ler o SQS.

Precisa ter o **ACCESS_KEY**, **ACCESS_SECRET** e a **REGION**.

```bash
#!/bin/bash
$ aws configure
AWS Access Key ID [None]: ACCESS_KEY
AWS Secret Access Key [None]: ACCESS_SECRET
Default region name [None]: REGION
Default output format [None]
```

Paths dos arquivos gerados:
 - ~/.aws/config
 - ~/.aws/credentials

### Configurando as filas que vão ser monitoradas
Basta incluir a URL da fila no arquivo de configuração **configs/queues.config**.

Exemplo:
```bash
https://queue.amazonaws.com/80398EXAMPLE/MyDeadLetterQueue
https://queue.amazonaws.com/80398EXAMPLE/MyQueue
https://queue.amazonaws.com/80398EXAMPLE/MyOtherQueue
https://queue.amazonaws.com/80398EXAMPLE/TestQueue1
https://queue.amazonaws.com/80398EXAMPLE/TestQueue2
```

### Executar
Para executar o script basta executar o script **view-queues.sh**

```bash
$ chmod +x view-queues.sh # Caso precise a permissão de execução
$ ./view-queues.sh
+-------------------------------------+---------------+
| Queue                               | MessageCount  |
+-------------------------------------+---------------+
| queue_1                             | 15            |
| queue_2                             | 0             |
| queue_3                             | 0             |
+-------------------------------------+---------------+
```

### Utilizando o Watch
Um comando auxiliar para poder monitorar é utilizar o **watch** que executa um comando por períodos de tempo.

Exemplo:
```bash
$ watch -n 10 ./view-queues.sh 
```

A cada 10 segundos o comando ./view-queues.sh será executado automaticamente.
# Rossum DevOps Task

## Start Gitlab
From the git root run:

 `docker-compose up -d gitlab`

Wait for some time to finish the start of Gitlab.
You can access it on http://localhost:8080 when ready.

## Setup API access to Gitlab
Please setup a root password and then create an API Token with API privileges:<br>
http://localhost:8080/-/profile/personal_access_tokens <br>
Add the token to terraform/variables.tf

The gitlab_server variable is already preset to work with this docker compose instance.

## Configure Gitlab with Terraform module
You can then apply atached terraform module to deploy users,groups and projects

`docker-compose run terraform init`

`docker-compose run terraform plan`

`docker-compose run terraform apply`


The module sets the following:

Creates 10 users<br>
Creates 3 groups (red,green,blue)<br>
Creates 3 projects per each group<br>
Assigns users to groups based on this:<br>
User 1: red<br>
User 2: red<br>
User 3: red, green<br>
User 4: green, blue<br>
User 5: green, blue<br>
User 6: red, green, blue<br>
User 7: green<br>
User 8: green<br>
User 9: red, blue<br>
User 10: blue




# Makefile - automatisation du provisioning AWS (NACL + EC2)
# Usage : make <cible> [VARIABLE=valeur ...]
# Exemple : make up VPC_ID=vpc-0ebcdb39f7a526ef9

# --- Variables configurables (surchargeables en ligne de commande) ---
REGION        ?= eu-west-3
VPC_ID        ?= vpc-0ebcdb39f7a526ef9
NACL_NAME     ?= vpc-ipssi-david
INSTANCE_TYPE ?= t2.micro
AMI_ID        ?= latest
EC2_NAME      ?= ec2-ipssi-david

# IDs requis pour les suppressions
NACL_ID       ?=
INSTANCE_ID   ?=

# --- Chemins vers les scripts ---
SERVICES_DIR := ../app/services
NACL         := $(SERVICES_DIR)/nacl.sh
COMPUTES     := $(SERVICES_DIR)/computes.sh

# Toutes les commandes aws utiliseront cette region
export AWS_DEFAULT_REGION = $(REGION)

.DEFAULT_GOAL := help
.PHONY: help check vpcs nacl nacl-delete ec2 ec2-delete up down

help: ## Affiche cette aide
	@echo "Cibles disponibles :"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-14s\033[0m %s\n", $$1, $$2}'
	@echo ""
	@echo "Variables (defauts) : REGION=$(REGION) VPC_ID=$(VPC_ID)"
	@echo "                      INSTANCE_TYPE=$(INSTANCE_TYPE) AMI_ID=$(AMI_ID) EC2_NAME=$(EC2_NAME)"

check: ## Verifie l'AWS CLI et l'identite (credentials)
	@aws sts get-caller-identity

vpcs: ## Liste les VPC de la region
	@aws ec2 describe-vpcs \
		--query 'Vpcs[].{ID:VpcId,Name:Tags[?Key==`Name`]|[0].Value,CIDR:CidrBlock,Default:IsDefault}' \
		--output table

nacl: ## Cree le NACL et ses regles (VPC_ID, NACL_NAME)
	@bash $(NACL) create $(VPC_ID) $(NACL_NAME)

nacl-delete: ## Supprime un NACL (NACL_ID=acl-xxx requis)
	@test -n "$(NACL_ID)" || { echo "NACL_ID requis : make nacl-delete NACL_ID=acl-xxx"; exit 1; }
	@bash $(NACL) delete $(NACL_ID)

ec2: ## Cree une instance EC2 (VPC_ID, INSTANCE_TYPE, AMI_ID, EC2_NAME)
	@bash $(COMPUTES) create $(VPC_ID) $(INSTANCE_TYPE) $(AMI_ID) $(EC2_NAME)

ec2-delete: ## Termine une instance EC2 (INSTANCE_ID=i-xxx requis)
	@test -n "$(INSTANCE_ID)" || { echo "INSTANCE_ID requis : make ec2-delete INSTANCE_ID=i-xxx"; exit 1; }
	@bash $(COMPUTES) delete $(INSTANCE_ID)

up: nacl ec2 ## Provisionne tout : NACL + EC2

down: ec2-delete nacl-delete ## Detruit tout (INSTANCE_ID et NACL_ID requis)

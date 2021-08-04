pipeline {
environment {
        AWS_ACCESS_KEY_ID     = credentials('ABI_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('ABI_SECRECT_KEY')
        AWS_DEFAULT_REGION = "us-east-1"
    }
agent  any
stages {
        stage('checkout') {
            steps {
                 script{

                        
                            git "https://github.com/Abishek-Ravichander/Terraform-Chef.git"
                        
                    }
                }
            }
        stage('AWS Connection Check') {
            steps {
                        sh '''
                        aws --version
                        aws ec2 describe-instances
                        '''
                }
            }
        
        stage('Plan') {
            steps {
                bat 'cd&cd terraform/Terraform-Chef & terraform init -input=false'
                bat 'cd&cd terraform/Terraform-Chef & terraform workspace new terraform_42'
                bat 'cd&cd terraform/Terraform-Chef & terraform workspace select terraform_42'
                bat "cd&cd terraform/Terraform-Chef & terraform plan -input=false -out tfplan "
                bat 'cd&cd terraform/Terraform-Chef & terraform show -no-color tfplan > tfplan.txt'
            }
        }
       

        stage('Apply') {
            steps {
                bat "cd&cd terraform/Terraform-Chef & terraform apply -input=false tfplan"
            }
        }
        
        
        stage('Upload Cookbook to Chef Server Coverage Nodes'){
steps{

 withCredentials([zip(credentialsID:'chef-server-creds',variable:'CHEFREPO')]){
sh'mkdir-p $CHEFREPO/chef-repo/cookbooks/apache'
sh 'sudo rm -rf $WORKSPACE/Berksfile.lock'
sh 'mv $WORKSPACE/* $CHEFREPO/chef-repo/cookbooks/apache'
sh "knife cookbook upload apache --force -o $CHEFREPO/chef-repo/cookbooks -c $CHEFREPO/chef-repo/.chef/knife.rb"
withCrecdentials([sshUserPrivateKey(credentialsID:agent-creds',keyFilevariable:'AGENT_SSHKEY', passphraseVariables:'',
sh "knife ssh 'role:webserver' -x ubuntu -i $AGENT_SSHKEY 'sudo Chef-client' -c $CHEFREPO/chef-repo/.chef/knife.rb"
}
                                    }
                                    }
                                    
        }
   }


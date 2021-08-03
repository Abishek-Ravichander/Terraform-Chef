pipeline {
environment {
        AWS_ACCESS_KEY_ID     = credentials('ABI_ACCESS_KEY')
        AWS_SECRET_ACCESS_KEY = credentials('ABI_SECRECT_KEY')
    }

stages {
        stage('checkout') {
            steps {
                 script{

                        
                            git "https://github.com/Abishek-Ravichander/Terraform-Chef.git"
                        
                    }
                }
            }

}


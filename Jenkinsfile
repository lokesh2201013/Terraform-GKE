properties(
    [
        parameters([
            string(
                defaultValue: 'dev'
                name: 'Environment'
            ),
            choice(
                choices:['plan','apply','destroy']
                name: 'Terraform_Action'
            )
        ])
    ]
)


pipeline{
    agent  any
    stages{
        stage("Preparing"){
            steps{
                sh 'echo Preparing'
            }
         }

        stage('Git pulling')
        {
            steps{
            git branch :  'main', url: ''
            }  
        }
        stage ('INIT')
        {
            steps{
              withCredentials([file(credentialsId:'gcp-creds',variable : 'GOOGLE_APPLICATION_CREDENTIALS')])
              {
               sh ' terraform -chdir=gke/init'
              }
            }
        }

        stage ('Validate')
        {
            steps{
              withCredentials([file(credentialsId:'gcp-creds',variable : 'GOOGLE_APPLICATION_CREDENTIALS')])
              {
                sh 'terraform -chdir=gke/validate'
              }
            }
        }


        stage('Action')
        [
            steps{
                 withCredentials([file(credentialsId: 'gcp-creds', variable: 'GOOGLE_APPLICATION_CREDENTIALS')])
                 {
                    script
                    {
                        if(params.Terrafor_action==plan)
                        {
                             sh "terraform -chdir=gke/ plan -var-file=${params.Environment}.tfvars"
                        }else  if(params.Terrafor_action==apply)
                        {
                             sh "terraform -chdir=gke/ apply -var-file=${params.Environment}.tfvars"
                        }else  if(params.Terrafor_action==destroy)
                        {
                             sh "terraform -chdir=gke/ destroy -var-file=${params.Environment}.tfvars"
                        } else {
                            error "Invalid value for Terraform_Action: ${params.Terraform_Action}"
                        }
                    }
                 }
            }
        ]
    }
   
}
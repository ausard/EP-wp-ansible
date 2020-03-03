#!groovy
pipeline { 
   agent any   
   options{
      //Time display
      timestamps()
   }
   stages {
      stage("Deploy wordpress with ansible"){
          steps{
            echo "====++++executing Deploy new version wordpress with ansible++++===="
            dir("/tmp/wp_ans"){
            //    sh "rm -rf *"
               git 'https://github.com/ausard/ansible_wordpress_docker.git'

               sh  "ansible-playbook --vault-password-file=vault_password wp.yml --extra-vars 'initialize_wp=${param.NEW_VERSION}'"

            //    script {
            //         if (params.initial) {
            //             sh "ansible-playbook --vault-password-file=vault_password wp.yml --extra-vars 'initialize_wp=true'"
            //         } else {
            //             sh  "ansible-playbook --vault-password-file=vault_password wp.yml"
            //         }
            //     }
            }
          }
          post{              
              success{
                  echo "====++++Deploy wordpress with ansible executed succesfully++++===="
              }
              failure{
                  echo "====++++Deploy wordpress with ansible execution failed++++===="
              }
      
          }
      }                   
   }
   post{
      success{  
          echo "Open your browser at http://localhost:8081/"
      }
   }      
}   

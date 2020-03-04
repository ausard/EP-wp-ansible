#!groovy
pipeline { 
   agent any   
   options{
      timestamps()
   }
   stages {
      stage("Deploy wordpress with ansible"){
          steps{
            echo "====++++executing Deploy new version wordpress with ansible++++===="
            dir("/tmp/wp_ans"){

               git 'https://github.com/ausard/EP-wp-ansible.git'

               sh  "ansible-playbook --vault-password-file=vault_password wp.yml --extra-vars 'initialize_wp=${params.NEW_VERSION}'"
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

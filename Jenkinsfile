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
              echo "====++++executing Deploy wordpress with ansible++++===="
              echo "Hello ${params.init_new_wp}"

          }
          post{
              always{
                  echo "====++++always++++===="
              }
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

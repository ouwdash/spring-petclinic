pipeline {
    //ENV 
    environment {     
         
        //ESSENTIALS
        APPNAME = "spring-petclinic"
        GIT = "https://github.com/ouwdash/spring-petclinic"
        
        // LOGS
        MAVEN_BUILD_LOG ="$WORKSPACE/log/maven-build.log"
        MAVEN_RUN_LOG = "$WORKSPACE/log/maven-run.log"
        
        // PACKAGE groovy
        def PKG_NAME ="target/spring-petclinic-2.0.0.BUILD-SNAPSHOT.jar"
        
        // Docker
        DOCKER = "springboot"
                    }
    //Draai op hoofdnode                
    agent {label "master"}
    
stages {
    stage('Build') {
        steps {
            echo "Cleaning Jenkins pipeline directory $WORKSPACE" 
            sh "sudo rm -Rf $WORKSPACE/*"
            echo "Getting package from Git... ($GIT)"
            sh "git clone $GIT $APPNAME"
            echo "Building package with Maven"
            sh "mv $WORKSPACE/$APPNAME/* $WORKSPACE/"
            sh "mkdir $WORKSPACE/log/"
            sh "./mvnw package &> $MAVEN_BUILD_LOG"
            echo "Printing the results from the logfile..."
            sh "awk '/Results:/{y=1;next}y' $MAVEN_BUILD_LOG" 
            }
        }
    stage('Test') {
            steps {
              echo 'Testing..'
                script{
                withEnv(['JENKINS_NODE_COOKIE=dontkill']) 
                {
                  sh "nohup java -jar $PKG_NAME &> $MAVEN_RUN_LOG &"
                }
                    timeout(1) {
                        waitUntil {
                        script {
                            def leven = sh script: 'curl -s http://localhost:8080 | grep "Welkom"', returnStatus: true
                            return (leven == 0);
                        }
                        }
            }
                echo "Test completed with success..."
                sh "cat $MAVEN_RUN_LOG | tail"
                }

            echo "Shutting down application $PKG_NAME.."
            
          // Kill process, get service > pid > pgrep ftw.
            script {
                 sh "pgrep -f $PKG_NAME > pid"
                // SCHRIJF bestand naar var.......gg
                def pid = readFile('pid').trim()  
                sh "kill $pid"
                sh "cat $MAVEN_RUN_LOG | tail"
                    }
                        
    
            }
        }
    stage('Deploy') {
            steps {
             script {
                echo "Preparing deployment"
                sh "docker build -t $DOCKER ."
                sh "docker run -p 8080:8080 -d --name ubuntu -it $DOCKER"
                sh "docker ps -q > container"
                def container = readFile('container').trim()
                echo "Generating logfile of service......"
                waitUntil {
                    script {
                        def leven = sh script: 'curl -s http://localhost:8080 | grep "Welkom"', returnStatus: true
                        return (leven == 0);
                            }
                            }
                sh "docker logs $container | tail"
                echo "======================================="
                sh "docker ps -as"
                echo "Goed Bezig! :)"
                echo  "======================================="
                 }
            }
        }
    }
}
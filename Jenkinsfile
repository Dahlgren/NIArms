pipeline {
  agent none

  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
  }

  stages {
    stage('Build') {
      steps {
        script {
          parallel createTargets()
        }
      }
    }
  }
}

def ignoreBat(cmd) {
  bat "${cmd}\nexit 0"
}

def createTargets() {
  def targets = [:]

  def folders = [
    'hlc_core',
    'hlc_wp_ACR',
    'hlc_wp_ak',
    'hlc_wp_AR15',
    'hlc_wp_aug',
    'hlc_WP_FAL',
    'hlc_wp_fhAWC',
    'hlc_wp_FN3011',
    'hlc_wp_g3',
    'hlc_wp_g36',
    'hlc_wp_m14',
    'hlc_wp_m16a2',
    'hlc_wp_m60E4',
    'hlc_wp_mg3',
    'hlc_wp_minigun',
    'hlc_wp_mp5',
    'hlc_wp_p226',
    'hlc_wp_saw',
    'hlc_wp_sigamt',
    'hlc_wp_springfield'
  ]

  folders.each { folder ->
    targets[folder] = {
      node('mikero') {
        try {
          checkout scm

          ignoreBat 'rmdir a3'
          bat 'mklink /j a3 "%A3_DATA%\\a3"'

          ignoreBat 'rmdir /s /q @niarsenal'
          bat 'mkdir @niarsenal'

          ignoreBat 'subst p: /d'
          bat 'subst p: %WORKSPACE%'

          bat "pboproject P:\\${folder} -P -Workspace=P:\\ +Mod=P:\\@niarsenal"
          archiveArtifacts artifacts: '@niarsenal/**/*'
        } finally {
          ignoreBat "type temp\\${folder}.bin.log"
          ignoreBat "type temp\\${folder}.packing.log"

          bat 'rmdir a3'
          bat 'subst p: /d'
        }
      }
    }
  }

  return targets
}

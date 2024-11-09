#!/bin/bash

# Définir les couleurs des variables
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # Aucune couleur

# Boucle while true pour faire un menu sur la gestion du pare-feu
while true; do
    echo -e "\n${GREEN}------ MENU GESTION PARE-FEU ------\n"
    echo -e "${CYAN}[1]${NC} Définir les règles de pare-feu"
    echo -e "${CYAN}[2]${NC} Activer le pare-feu"
    echo -e "${CYAN}[3]${NC} Désactiver le pare-feu"
    echo -e "${CYAN}[4]${NC} Retour au menu principal\n"
    read -p "Veuillez choisir une option : " choix

    # Case pour faire un sous-menu pour les règles du pare-feu
    case $choix in 
        
         # Boucle while true pour faire un menu sur les règles du pare-feu
     1)
          while true; do
          echo -e "${GREEN}------ MENU DES RÈGLES PARE-FEU ------\n"
          echo -e "${CYAN}[1]${NC} Ajouter une règle"
          echo -e "${CYAN}[2]${NC} Supprimer une règle"
          echo -e "${CYAN}[3]${NC} Afficher les règles actuelles"
          echo -e "${CYAN}[4]${NC} Retour au menu principal\n"
          read -p "Veuillez choisir une option : " choix_regles
    
          case $choix_regles in

    		       # Ajouter une règles de pare-feu
                 1)     
                        read -p "$(echo -e "\n${GREEN}Entrer la règle à ajouter (ex: allow 22/tcp) : ${NC}")" regle
                        sudo ufw $regle
                        echo -e "${GREEN}Règle ajoutée : $regle${NC}\n"
                        ;;

                   # Supprimer une règle de pare-feu     
                   2)
                        read -p "$(echo -e "\n${GREEN}Entrer la règle à supprimer (ex: allow 22/tcp) : ${NC}")" regle
                        sudo ufw delete $regle
                        echo -e "${GREEN}Règle supprimée : $regle${NC}\n"
                        ;;

                   # Voir les règles de pare-feu actuelle     
                   3)
                        echo -e "${GREEN}Règles de pare-feu actuelles :${NC}\n"
                        sudo ufw status
			         echo ""
                        ;;

                   # Retour au menu principal     
                   4)
                        break
                        ;;

                   # Indique une erreur de saisie et demande de réessayer une saisie valide     
                   *)
                        echo -e "${RED}[Erreur]! Option invalide, veuillez réessayer !${NC}\n"
                        ;;
                esac
            done
            ;;
            # Fin de la case                 	 	
            	            
           # Activation du pare-feu          
           2)
	          # Activation du pare-feu
               read -p "$(echo -e "${GREEN}Voulez-vous activer le pare-feu ? (oui/non) : ${NC}")" oui

                # Tant que l'entrée n'est pas "oui" ou "non", on redemande une saisie valide
                while [[ "$oui" != "oui" && "$oui" != "non" ]]; do
                      echo -e "\n${RED}[ERREUR] Option invalide, veuillez entrer 'oui' ou 'non'.${NC}\n"
                      read -p "Entrer votre choix : " oui
                done
                # Fin de la boucle

               echo ""

                # Si la valeur saisie est "oui" alors le pare-feu s'active sinon si la saisie est "non" alors rien ne se passe
                if [ "$oui" = "oui" ]; then
                   sudo ufw enable
                   echo -e "\n${YELLOW}Le pare-feu a bien été activé.${NC}\n"
                else
                   echo -e "\n${YELLOW}Le pare-feu n'a pas été activé.${NC}\n"
                fi
                ;; 

           3)
	        # Désactivation du pare-feu
                read -p "$(echo -e "${GREEN}Voulez-vous désactiver le pare-feu ? (oui/non) : ${NC}")" oui

                # Boucle pour que tant que l'entrée n'est pas "oui" ou "non", on redemande une saisie valide
                while [[ "$oui" != "oui" && "$oui" != "non" ]]; do
                      echo -e "\n${RED}[ERREUR] Option invalide, veuillez entrer 'oui' ou 'non'.${NC}\n"
                      read -p "Entrer votre choix : " oui
                done
                # Fin de la boucle

               echo ""

                # Si la valeur saisie est "oui" alors le pare-feu se désactive sinon si la saisie est "non" alors rien ne se passe
                if [ "$oui" = "oui" ]; then
                   sudo ufw disable
                   echo -e "\n${YELLOW}Le pare-feu a bien été désactivé.${NC}\n"
                else
                   echo -e "\n${YELLOW}Le pare-feu n'a pas été désactivé.${NC}\n"
                fi
                ;;   
		
           # Retour au menu principal  
           4)
                break
	        ;;
       
           # Indique si erreur de saisie et relance le script 
           *)
            echo -e "${RED}[Erreur]! Option invalide, veuillez réessayer !${NC}\n"
            ;;
   esac
done 
# Fin du script

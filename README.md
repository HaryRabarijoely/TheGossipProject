# README
# THP - the gossip project
# Hary ANDRIANARISOA

Guide :
voici les differentes tables crées :
	- City - les villes
	- User - les utilisateurs
	- Comment - les commentaires
	- Gossip - les cossips
	- Tag - les tags
	- GossipTag - le N-N gossips-tags
	- PrivateMessage - les pm
	- RecipientList - le 1-N private_message - recipients
	- user - les user (ajout des senders et recipients)

notes :

- Les commentaires sont soit lies a un gossipID soit a un autre commentaireID (comment of comment)
- les likes sont soit relies a un commentaireID soit a un gossipID

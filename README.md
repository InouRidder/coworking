# README

### Code Challenge

* Ruby version - 2.6.5

* test suite: rspec

* Deployment - heroku


### Instructions


Your Client is a French Coworking space that rents workstations to freelancers. When someone is accepted into the coworking space, he signs a contract that is renewed automatically every month. Because of the high demand, the Client needs to put in place a waiting list in order to keep track of people wanting to join the coworking.
The main features that the Client has specified:
* A public accessible form to collect incoming requests (name, email, phone number, a brief biography about the freelancer). Each field must be validated in order to have data as accurate as possible.
* Email addresses must be confirmed (requests with emails that have not been confirmed should not be taken into account by the waiting list).
* The requests will be accepted on a first-come, first served principle
* The requests in the waiting list must be reconfirmed every 3 months: an email should be sent to the people in the waiting list, informing them of their order in the waiting list and asking for confirmation that they are still interested, otherwise their request will be removed from the waiting list (aka expired).
For the scope of this test, an administration interface is not required. However, you need to provide methods that the Client could use in rails console :
* request.accept! - method that will allow accepting a request (request being an instance of the class Request)
* list the requests by their status using class methods or scopes
** Request.unconfirmed - requests for which the email address has not been confirmed
** Request.confirmed - requests in the waiting list
** Request.accepted - requests that have been accepted by the client
** Request.expired - requests that have not been reconfirmed
The app should be hosted on a free Heroku hosting plan.

-----------------------------------------------------------------------------

### L’API du Client:

J’ai crée plusier des jobs pour le client pour manage son enterprise
Contracts::RenewJob
# Cette job renouvelle les contrats qui en sont à leur dernier jour d'utilisateurs actifs
Desks::DistributionJob
# Cette job distribue les Desks libre aux utilisateurs de la liste d'attente
Requests::ExpireRequestsJob
# Cette job expire les Requests qui sont passe son temps de confirmé
Requests::RequestConfirmationsJob
# Cette job envoire des e-mails a les Request.confirmed pour le reconfirmer

Request.confirmed - Request.unconfirmed - Request.accepted - Request.expired
(comme demandé)

chaque jour, il y a un Job qui se lance rails daily:run et cette job lancee tous les Jobs en haut.

vous pouvez trouve ton email ici:
https://coworking-inou-hexagonal.herokuapp.com/letter_opener



### les décisions que j’ai prises

J’ai essaye de crée un projet plus future proof
J’ai ajouté des truc qui ne sont pas essentiel, maintenant, mais en preparation du futur.

- Devise pour auth, et temp password pour utilisateurs. Pour moi c’est plus extensible, comme celui le code est preparé pour un plateforme et le Client peut décider de mettre à niveau la plateforme et de se connecter à l’avenir

- Creation contracts / users / desks
- Auto renouvables des contracts

### Limitations connues
(desks#index) Je crois qu’ici, j’aurais pu utiliser de meilleures pratiques en termes de caching - pagination - model.presenters! Si j'avais plus de temps, j'aurais implémenté ce

Je doutais de maintenir ou non l’ordre dans la liste d’attente sur la demande, cela aurait été plus simple dans la DSL, mais ca crée le ‘overhead’ de managée l’Etat et  la liste est toujours présentée dans une itération de toute façon, donc en fin j’ai prend la decision  d’utiliser l’index de l’itération.

Tous les jobs/emails sont synchronous car du plan gratuit heroku ne permet qu’un seul dyno, n’a pas pu ajouter redis et sidekiq

### en général
Je suis allé un peu trop loin dans la création de fonctionnalités supplémentaires où je pense que j’aurais pu optimiser davantage les exigences de base


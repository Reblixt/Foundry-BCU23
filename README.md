# Foundry-BCU23

## Installation av Foundry
Hemsidan till all documentation för foundry hittar du du på denna länk [Foundry book](https://book.getfoundry.sh/getting-started/installation).
1. För att installera Foundry så kör detta kommando i terminalen
```bash
curl -L https://foundry.paradigm.xyz | bash
```
2. Därefter så stänger du ned terminalen och öpnnar en ny terminal. 
Varför? För att terminalen ska uppdatera PATH variabeln så att den hittar Foundry kommandon

3. Därefter så kör du detta kommando för att sista installationen
```bash
foundryup
```
4. För att verifiera att Foundry är installerat så kör detta kommando
```bash
forge --version
```

## Klona detta repo och installera paketen
1. För att clone detta repo och gå in i mappen
```bash
git clone https://github.com/Reblixt/Foundry-BCU23.git
cd Foundry-BCU23
```

2. För att installera paketen som behövs för att kontrakten ska kunna fungera
```bash
forge install foundry-rs/forge-std --no-commit
forge install OpenZeppelin/openzeppelin-contracts --no-commit
```
3. Lägg till denna rad i din .env fil plus din Alchemy URL
``` file
ALCHEMY_URL=
PRIVATE_KEY=
```

## Lite Konfiguration pga att vi använder OpenZeppelin
Lägg till denna rad i foundry.toml för att berätta för Foundrys hur den ska hitta alla kontract för att 
kompilera dem. Samt för att berätta för Solidity LSPn hur den ska hitta alla kontrakt för att ge autocompletion.

```toml
remappings = ["@openzeppelin/contracts/=lib/openzeppelin-contracts/contracts/",]
```
## Resurser
[OpenZeppelin](https://www.openzeppelin.com/) -- | -- [Cyfrin Updraft](https://updraft.cyfrin.io/) -- | -- [Foundry book](https://book.getfoundry.sh)

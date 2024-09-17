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
- Jag har installerat paket genom Soldeer some är ett package manager för Solidity. Likt som NPM är för Node.js.
Jag har installerat detta paket
```bash
forge soldeer install @openzeppelin-contracts~5.0.2
```

2. För att installera paketen som behövs för att kontrakten ska kunna fungera
```bash
forge build
eller 
forge compile
```
3. Lägg till denna rad i din .env fil plus din Alchemy URL
``` file
ALCHEMY_URL=
PRIVATE_KEY=
```

## Resurser
[OpenZeppelin](https://www.openzeppelin.com/) -- | -- [Cyfrin Updraft](https://updraft.cyfrin.io/) -- | -- [Foundry book](https://book.getfoundry.sh) -- | -- [Alchemy](https://dashboard.alchemy.com/) -- | -- [Soldeer](https://soldeer.xyz/)


### UML

소개 <br/>
: https://torbjorn.tistory.com/609 <br/>

platn uml <br/>
: https://github.com/plantuml/plantuml <br/>
: https://www.plantuml.com/plantuml/uml/SyfFKj2rKt3CoKnELR1Io4ZDoSa70000 <br/>
: https://pdf.plantuml.net/PlantUML_Language_Reference_Guide_ko.pdf <br/>

kroki <br/>
: https://github.com/yuzutech/kroki <br/>
: https://kroki.io/ <br/>

<center>
<img src="//www.plantuml.com/plantuml/png/SoWkIImgAStDuNBAJrBGjLDmpCbCJbMmKiX8pSd9vt98pKi1IW80" width="50%" border-radius="90px"></img>
</center>

<center>
<img src="https://kroki.io/plantuml/svg/eNpljzEPgjAQhff-iguTDFQlcYMmuru5mwNO0tCWhjY6GP-7LRJTdHvv7r67d26QxuKEGiY0gyML5Y65b7GzEvblIalYbAfs6SK9oqOSvdFkPCi6ecYmaj2aXhFkZ5QmgycD2Ogg-V3SI4_OyTjgR5OzVwqc0NECNEHydtR2NGH3TK2dHjtSP3zViPmQd9W2ERmgg-iv3jGW4MC5-L-wTEJdi1XeRENRiFWOtMfnrclriQ5gJD-Z3x9beAM=" width="50%" border-radius="90px"></img>
</center>


### Sequence.

### Usecase.

```python plantuml-startuml
    @startuml
    left to right direction
    actor "User" as fc
    rectangle Restaurant {
    usecase "Eat Food" as UC1
    usecase "Pay for Food" as UC2
    usecase "Drink" as UC3
    }
    fc --> UC1
    fc --> UC2
    fc --> UC3
    @enduml

```

<center>
<img src="//www.plantuml.com/plantuml/png/JS_DgeD03CNnVPxYuDx5rVr5wCUw57o0C6RiK3k1J5oKqdUlbeBk3lpu1z8LP_FvCT4aqU4AI-FDCIIJu4apSN0rL7qHgy05CT1AdCT9S9MbduspuqN0N2Hm4LGdTfnLXs_H7_xsTk4dejhUcxqVBUNx3rfwKmoew__roZQRRRRKIHwM3pu0" width="50%" border-radius="90px"></img>
</center>

### Flow.

### WBS

### Bytefield.


### JSON Data. Display

```python plantuml-startuml
    @startjson
    {
    "fruit":"Apple",
    "size":"Large",
    "color": ["Red", "Green"]
    }
    @endjson

```

<center>
<img src="//www.plantuml.com/plantuml/png/SoWkIImgoIhEp-Egvb9GK51AAohDB56oKd8iACX9LT81YnLdLgK2XNmIYz9XGidvEVb5IbOAqKf1gIbAEWfAxaMfgNbAiLorN0wfUIaW0m40" width="50%" border-radius="90px"></img>
</center>
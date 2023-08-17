
     Versjon av Xcode: 
     xcode 14.0
     SwiftUI
     Simulator iOS 16.0. 
     Testet på Iphone 14, 14 plus, 14 Pro Max, 12 og 13


      Brukererens "reise" fra start til slutten i denne appen (hvordan den fungerer)
      
      1. Brukeren åpner appen og blir presentert med en loading screen med en spinner. Når denne er ferdig å kjøre, kommer det opp tilfeldige aktiviter. Brukeren kan trykke på knappen "Finn ny aktivitet" og får da nye aktiviteter.
          Dersom en aktivitet koster 0.0, vil den vises som gratis i feltet for pris. Dersom en aktivitet ikke har en link står det "Har ikke link", i feltet for "Link""
      
      2. Brukeren kan trykke på "Deltaker filter" felter. Her kan man skrive inn antall deltakere man ønsker å filterere på. Eller man kan filtrere. Striver man et tall som er 101 eller høyere, får man en feilmelding. Denne forsvinner igjen om man fjerner 101 tallet fra input feltet. 
      
      
      NB! Merk at:
        2.1: FILTER LAGRES lokalt på telefonen. Dersom man lukker appen og skrur den på igjen, vil den fortsatt bruke tidligere filtrerings input. Helt til man endrer dette, eller trykker på knappen for å fjerne filtrering på forside. Trykker man på denne knappen, vil filter skrus av, og knappen for å skru av filtrering, vil også finne en ny tilfeldig aktivitet og kjøre en loading animasjon først.
        
        2.2: Selv om man vil teste ut filter, er det ikke ønskelig at ny aktivitet vises før brukeren igjen trykker på "Finn ny aktivitet". I tilfelle brukeren glemte å lagre denne aktiviteten først.
            Når man så trykker på knappen "Finn ny aktivitet" etter at man aktivert filter, vil en ny aktivitet dukke opp, med det valgte antallet deltakere. Knappen for å deaktivere filter, har nå blitt rød, og har endret tekst. 
            
            OM MAN HAR PÅ FILTER NÅR MAN SKRUR AV APPEN, VIL DENNE HUSKES TIL NESTE GANG FØR DEN SKRUS AV. 
            Dersom man filtrerer på et tall under 101, som ikke har deltaker antall, får man ikke opp api kall, men man kan da deaktivere filter, og få opp en tilfedig aktivet igjen, med tilfeldig antall deltakere. 
           
           
            
        3. Når man går på "Registrer gjennomført aktivitet", får man en knapp hvor det står dagens dato. Her kan man trykke seg inn på en kalender. Som standard får man ikke velge datoer fremover i tid. Da dette er en app for å registrere ting man HAR gjort. Men dersom man vil det, finnes det et valg om å også kunne sette fremtidige datoer. 
            Når man har bestemt seg for en dato (eller bare latt den stå på dagens dato), kan man registrere. Før man lukker denne siden, får man en kjapp delay som gjør at man rekker å se en melding om at aktiviteten er blitt registrert, får man navigeres tilbake til forsiden. 
            
          
          4. På gjennomførte aktivitets siden, finner man alle aktivteter man har lagret. Disse er lagret på telefoen. 
              Alle aktiviter er sortert i seksjoner for dato. Dette vil si at dersom man har lagret flere enn en aktivitet på samme dag, vil aktivitene på samme dag seksjoneres. Aktiviter er seksjonert med de nyeste først. Blar man nedover finner man eldre og eldre aktiviter. 
              
              Hver dag har også en oversikt over hvor mange penger man har brukt på aktiviter per dag. Det vil si om man har brukt 1 dollar på en ting, 2 dollar på en annen ting, på samme dag, så vil det stå at man har brukt totalt 3 dollar den dagen. 
              Man finner også en oversikt over hva man har totalt har brukt på aktiviter. 
              Brukeren har også et alternativ for å slette alle aktiviter loggført. Disse vil da forsvinne visuelt med en gang. 
              
              
          5. Man kan så trykke seg inn på den enkelte lagrede aktivitet. Gjør man dette, så får man detaljer om denne. Samtidig som det kommer en animasjon basert på om aktiviteten er helt gratis eller ikke. 
          
          
          
          Kommentarer: 
    
          1. Det har vært noe problemer med å bruke xcode versjon 14.0 
          Grunnet at jeg ikke husket passordet mitt for å logge inn i appel kontoen min for å endre versjon til en eldre versjon av xcode (og jeg hørte det skulle ta 5 dager for å få tilsendt nytt passord om man trykker på "glemt passord"), så ble det å utføre denne eksamen på 14.0 
          Blant annet hadde xcode bestemt seg for å fjerne knapper man bruker når man setter opp core data. 
          I dette prosjektet har jeg brukt userDefault. Jeg er klar over at man ikke må lagre for mye data i userDefault og at dette kan føre til at appen blir tregere om det lagres mye data. Men i dette prosjektet har det vært snakk om veldig lite data som ikke har tatt noe særlig lagringsplass. Men i et virkelig prosjekt hvor mer data lagres, ville det så klart vært en fordel med core data. 
          Det er uansett verdt å merke seg at jeg har lagt til knapp for å slette alle aktiviter :) 
          
          
          2. Jeg har kommentert noe underveis i koden. I et virkelig prosjekt, ville man kanskje ikke kommentert like mye, da dette sikkert kan se litt rotete ut for folk i bransjen. Men jeg har kommentert noe for å prøve å vise forståelse, da dette er en skoleoppgave. God navngiving er også viktig for å gjøre koden leseling. I arbeidslivet, kommenteres det på engelsk. Jeg har kommentert på norsk i denne oppgaven.
          Grunnet tidspress, ble det ikke tid til å kommentere alt. 
          
          3. NB. DET STOD STØRRE ENN 100 I OPPGAVEN. Gir kun advarsel ved 101 eller høyere tall på filter. 
          
          
          warning run: Publishing changes from within view updates is not allowed, this will cause undefined behavior.
          Skulle helst unngått denne. Men grunnet tidspress, fant jeg ikke en løsning på dette, uten å miste funksjonalitet. 


            
              
            



      Kilder: 

      SwiftUI - Fetching json data from an API (GET & POST HTTP requests) using URLSession:
        //https://www.youtube.com/watch?v=z_2iiq0MjmM&t=1s&ab_channel=ODENZA


     Symboler for tabs:
      //https://sfsymbols.com/
    
     Lagre array i UserDefaults
     //https://stackoverflow.com/questions/25179668/how-to-save-and-read-array-of-array-in-nsuserdefaults-in-swift

     
     Dato:
     //https://www.swiftlyrush.com/date-formatting-in-swiftui/
     
     DatePicker:
     //https://sarunw.com/posts/swiftui-multidatepicker/
     
     For å disable fremtidge datoer:
     //https://stackoverflow.com/questions/73081502/how-to-disable-the-future-date-selection-from-datepicker-in-swiftui

    DateFormatter:
    //https://developer.apple.com/documentation/foundation/dateformatter
    
    Farge progressview: 
    //https://developer.apple.com/forums/thread/652733
    
    
    Summere verdier i loop 
    // //https://stackoverflow.com/questions/61827511/how-do-i-sum-values-from-a-list-in-swiftui
    
    Summere verdier properties objekt 
    //https://stackoverflow.com/questions/43911721/sum-values-of-properties-inside-array-of-custom-objects-using-reduce
    
    Directory grouping
    //https://developer.apple.com/documentation/swift/dictionary/init(grouping:by:)
    
    Sorted by: 
    //https://developer.apple.com/documentation/swiftui/binding/sorted(by:)
    
    TextField
    //https://stackoverflow.com/questions/59507471/use-bindingint-with-a-textfield-swiftui
               


                

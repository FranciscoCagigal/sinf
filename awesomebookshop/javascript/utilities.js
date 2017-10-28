function sortTable(index, tipe, sortFlag) {
    var table, rows, switching, i, x, y, shouldSwitch;
    table = document.getElementById("myTable");
    switching = true;
    /*Make a loop that will continue until no switching has been done:*/
    while (switching) {
      //start by saying: no switching is done:
      switching = false;
      rows = table.getElementsByTagName("TR");
      /*Loop through all table rows (except the first, which contains table headers):*/
      for (i = 1; i < (rows.length - 1); i++) {
        //start by saying there should be no switching:
        shouldSwitch = false;
        /*Get the two elements you want to compare, one from current row and one from the next:*/
       
           if( tipe === "INTEGER") {
              x = parseFloat( (rows[i].getElementsByTagName("TD")[index]).innerText.replace(' €', '') );
              y = parseFloat( (rows[i + 1].getElementsByTagName("TD")[index]).innerText.replace(' €', '') );
           }else{
             x = rows[i].getElementsByTagName("TD")[index].innerText.toLowerCase();
             y = rows[i + 1].getElementsByTagName("TD")[index].innerText.toLowerCase();
           }
            
          if (x > y && !sortFlag) {
            //if so, mark as a switch and break the loop:
            shouldSwitch= true;
            break;
          }
          else if (x < y && sortFlag) {
            //if so, mark as a switch and break the loop:
            shouldSwitch= true;
            break;
          }
      }

      if (shouldSwitch) {
        /*If a switch has been marked, make the switch and mark that a switch has been done:*/
        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
        switching = true;
      }

    } 

  }

function sortTableDateAll(index, sortFlag) {
    var table, rows, switching, i, x, y, shouldSwitch;
    table = document.getElementById("myTable");
    switching = true;
    /*Make a loop that will continue until no switching has been done:*/
    while (switching) {
      //start by saying: no switching is done:
      switching = false;
      rows = table.getElementsByTagName("TR");
      /*Loop through all table rows (except the first, which contains table headers):*/
      for (i = 1; i < (rows.length - 1); i++) {
        //start by saying there should be no switching:
        shouldSwitch = false;
        /*Get the two elements you want to compare, one from current row and one from the next:*/
       
            x = (rows[i].getElementsByTagName("TD")[index]).innerText;
            y = (rows[i + 1].getElementsByTagName("TD")[index]).innerText;

            // X
            split = x.split(' ');
            date = split[0];
            horas = split[1];

            split = date.split('-');
            diax = split[0];
            mesx = split[1];
            anox = split[2];

            split = horas.split(':');
            horax = split[0];
            minutox = split[1];
            segundox = split[2];

            // Y
            split = y.split(' ');
            date = split[0];
            horas = split[1];

            split = date.split('-');
            diay = split[0];
            mesy = split[1];
            anoy = split[2];

            split = horas.split(':');
            horay = split[0];
            minutoy = split[1];
            segundoy = split[2];

            if(!sortFlag){
              if (anox > anoy) {
                shouldSwitch = true;
                break;
              }
              else if (anox == anoy && mesx > mesy) {
                shouldSwitch = true;
                break;
              }
              else if (anox == anoy && mesx == mesy && diax > diay) {
                shouldSwitch = true;
                break;
              }
              else if (anox == anoy && mesx == mesy && diax == diay && horax > horay) {
                shouldSwitch = true;
                break;
              }
              else if (anox == anoy && mesx == mesy && diax == diay && horax == horay && minutox > minutoy) {
                shouldSwitch = true;
                break;
              }
              else if (anox == anoy && mesx == mesy && diax == diay && horax == horay && minutox == minutoy && segundox > segundoy) {
                shouldSwitch = true;
                break;
              }
            }
            else{
              if (anox < anoy) {
                shouldSwitch = true;
                break;
              }
              else if (anox == anoy && mesx < mesy) {
                shouldSwitch = true;
                break;
              }
              else if (anox == anoy && mesx == mesy && diax < diay) {
                shouldSwitch = true;
                break;
              }
              else if (anox == anoy && mesx == mesy && diax == diay && horax < horay) {
                shouldSwitch = true;
                break;
              }
              else if (anox == anoy && mesx == mesy && diax == diay && horax == horay && minutox < minutoy) {
                shouldSwitch = true;
                break;
              }
              else if (anox == anoy && mesx == mesy && diax == diay && horax == horay && minutox == minutoy && segundox < segundoy) {
                shouldSwitch = true;
                break;
              }
            }
      }

      if (shouldSwitch) {
        /*If a switch has been marked, make the switch and mark that a switch has been done:*/
        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
        switching = true;
      }

    } 

  }

 function sortTableDate(index, sortFlag) {
    var table, rows, switching, i, x, y, shouldSwitch;
    table = document.getElementById("myTable");
    switching = true;
    /*Make a loop that will continue until no switching has been done:*/
    while (switching) {
      //start by saying: no switching is done:
      switching = false;
      rows = table.getElementsByTagName("TR");
      /*Loop through all table rows (except the first, which contains table headers):*/
      for (i = 1; i < (rows.length - 1); i++) {
        //start by saying there should be no switching:
        shouldSwitch = false;
        /*Get the two elements you want to compare, one from current row and one from the next:*/
       
            x = (rows[i].getElementsByTagName("TD")[index]).innerText;
            y = (rows[i + 1].getElementsByTagName("TD")[index]).innerText;

            // X
            split = x.split('-');
            diax = split[0];
            mesx = split[1];
            anox = split[2];

            // Y
            split = y.split('-');
            diay = split[0];
            mesy = split[1];
            anoy = split[2];

            if(!sortFlag){
              if (anox > anoy) {
                shouldSwitch = true;
                break;
              }
              else if (anox == anoy && mesx > mesy) {
                shouldSwitch = true;
                break;
              }
              else if (anox == anoy && mesx == mesy && diax > diay) {
                shouldSwitch = true;
                break;
              }
            }
            else{
              if (anox < anoy) {
                shouldSwitch = true;
                break;
              }
              else if (anox == anoy && mesx < mesy) {
                shouldSwitch = true;
                break;
              }
              else if (anox == anoy && mesx == mesy && diax < diay) {
                shouldSwitch = true;
                break;
              }
            }

            if (y.length > 3 && (x.length == 3)) {
              //if so, mark as a switch and break the loop:
              shouldSwitch= true;
              break;
            }
      }

      if (shouldSwitch) {
        /*If a switch has been marked, make the switch and mark that a switch has been done:*/
        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
        switching = true;
      }

    } 

  } 

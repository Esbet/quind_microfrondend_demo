String homejsScript = '''
      document.querySelector('.Homepage_dealformAreaContainer__HU8qO').style.display = 'none';
      document.querySelector('.Header_header___2Goy').style.display = 'none';
      document.querySelector('.PriceCalendar_container__WZ97_').style.display = 'none';
      document.querySelector('.Footer_wrapperTest__bhcIX').style.display = 'none';   
      document.querySelector('.seo-modules_linkListContainer__0pNRg').style.display = 'none';
      
      var articles = document.querySelectorAll('.IndependentHotel_card__y6WUx a');
      articles.forEach(function(article) {
        article.addEventListener('click', function(event) {
          event.preventDefault(); // Prevenir la navegación predeterminada
          var href = article.getAttribute('href');
          window.FlutterChannel.postMessage('navigateTo:' + href);
        });
      });  
''';

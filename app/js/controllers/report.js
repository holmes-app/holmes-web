(function() {
  'use strict';
  var availableViolations;

  availableViolations = [
    {
      url: "g1.globo.com/politica/noticia/2013/09/tse-confirma-criacao-do-pros-31-partido-do-pais.html",
      text: "Too many requests. This page performs 2,450 requests and that takes its toll in the overall performance of the page.",
      page: 1,
      id: 1
    }, {
      url: "g1.globo.com",
      text: "No sitemap could be found for this domain. Having a sitemap is important because of reason.",
      page: 2,
      id: 2
    }, {
      url: "globo.com",
      text: "No opengraph metadata found for this page. This can hurt social sharing because it makes it harder for the social networks to understand what this page is about.",
      page: 3,
      id: 3
    }, {
      url: "ego.globo.com",
      text: "Total request size too big. This page loads 5mb of html, javascript, stylesheets and images. In a slower connection this will definitely hurt the overall user experience.",
      page: 4,
      id: 4
    }, {
      url: "ego.globo.com/paparazzo/noticia/2013/09/angelis-sobre-caio-castro-estava-ha-dois-anos-sem-ficar-com-um-homem.html",
      text: "No keywords metadata found. This may decrease search engines' ability to understand the topics of interest in this page.",
      page: 5,
      id: 5
    }
  ];

  angular.module('holmesApp').controller('ReportCtrl', function($scope, $routeParams) {
    var domainId, i, item, sinAndCos, _i;
    $('#reportTabs').tab();
    sinAndCos = function() {
      var cos, i, sin, _i;
      sin = [];
      cos = [];
      for (i = _i = 0; _i <= 100; i = ++_i) {
        sin.push({
          x: i,
          y: Math.sin(i / 10)
        });
        cos.push({
          x: i,
          y: .5 * Math.cos(i / 10)
        });
      }
      return [
        {
          values: sin,
          key: 'Sine Wave',
          color: '#ff7f0e'
        }, {
          values: cos,
          key: 'Cosine Wave',
          color: '#2ca02c'
        }
      ];
    };
    domainId = $routeParams.domainId;
    $scope.domain = {
      name: "Domain " + domainId
    };
    $scope.violations = [];
    for (i = _i = 1; _i <= 20; i = ++_i) {
      item = angular.copy(availableViolations[Math.floor(Math.random() * availableViolations.length)]);
      item.added = new Date().toISOString();
      item.addedString = jQuery.timeago(item.added);
      $scope.violations.push(item);
    }
    return nv.addGraph(function() {
      var chart;
      chart = nv.models.lineChart();
      chart.xAxis.axisLabel('Time (ms)').tickFormat(d3.format(',r'));
      chart.yAxis.axisLabel('Voltage (v)').tickFormat(d3.format('.02f'));
      d3.select('#chart svg').datum(sinAndCos()).transition().duration(500).call(chart);
      nv.utils.windowResize(function() {
        return d3.select('#chart svg').call(chart);
      });
      return chart;
    });
  });

}).call(this);

/*
//@ sourceMappingURL=report.js.map
*/
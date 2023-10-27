<!-- "use client";

import { useEffect, useState } from "react";
// import { Doughnut } from "react-chartjs-2";

export default function VisitorsGraph() {
    const [chartData, setChartData] = useState({});

  useEffect(() => {
    async function getCountriesData() {
      const countriesResponse = await fetch(`http://5.22.222.152:8080/unique-ips-by-country`, {
        method: 'GET',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer`,
        },
        mode: 'no-cors',
      });

      console.log(countriesResponse);

      if (countriesResponse.ok) {
        const countriesUnprocessedData = await countriesResponse.json();

        // Convert the object to an array of arrays containing only values
        // @ts-ignore
        const countryCountArrOfArrs = countriesUnprocessedData.map((entry) => Object.values(entry));
        // @ts-ignore
        const sortedCountryCountArrOfArrs = countryCountArrOfArrs.sort(function(a, b) {
          return b[1] - a[1];
        });

        const firstFiveCountriesArrOfArrs = sortedCountryCountArrOfArrs.slice(0, 5);
        // @ts-ignore
        const otherCountriesCount = sortedCountryCountArrOfArrs.slice(5).reduce((partialSum, a) => partialSum + a[1], 0);

        // @ts-ignore
        const firstFiveCountriesCounts = firstFiveCountriesArrOfArrs.reduce((arr, val) => arr.concat(val[1]), []);
        // @ts-ignore
        const firstFiveCountriesLabels = firstFiveCountriesArrOfArrs.reduce((arr, val) => arr.concat(val[0]), []);

        const countriesData = {
          labels: firstFiveCountriesLabels.concat("Other"),
          data: firstFiveCountriesCounts.concat(otherCountriesCount),
        };

        const data = {
          labels: countriesData.labels,
          datasets: [
            {
              data: countriesData.data,
              backgroundColor: [
                '#EE2E31',
                '#1D7874',
                '#679289',
                '#F4C095',
                'rgb(104,0,0)',
                'rgb(110,111,92)',
              ],
              hoverBackgroundColor: [
                '#EE2E31',
                '#1D7874',
                '#679289',
                '#F4C095',
                'rgb(104,0,0)',
                'rgb(110,111,92)',
              ],
            },
          ],
        };

        setChartData(data);
      }
    }

    getCountriesData();
  }, []);

  const options = {
    responsive: true,
    elements: { arc: { borderWidth: 0 } },
    plugins: {
      legend: {
        labels: {
          color: 'rgb(170 170 170)',
        },
        position: 'right',
      },
    },
    cutout: '70%',
    rotation: 90,
  };

  return (
    <div>
      {/* @ts-ignore */}
      {/* {chartData && <Doughnut data={chartData} options={options} />} */}
    </div>
  );
}; -->
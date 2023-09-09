<script>
  // @ts-nocheck

  import { Doughnut } from 'svelte-chartjs'
  import {
    Chart as ChartJS,
    Title,
    Tooltip,
    Legend,
    ArcElement,
    CategoryScale,
  } from 'chart.js'

  import SwipeWrapper from "../../components/SwipeWrapper.svelte"
  import GreyCard from '../../components/GreyCard.svelte'

  let leftLink = "/about"
  let rightLink = "/contact"

  async function getCountriesData() {
    let countriesResponse = await fetch('/data/countries-data', {
      method: 'GET',
      headers: {
        'content-type': 'application/json'
      }
    })
    let countriesData = await countriesResponse.json()

    const key = 'ip_address'
    const countriesDataUniqueByIP = [...new Map(countriesData.map(item =>[item[key], item])).values()]

    // ⬇️ Making the unique IP data graphable 

    const countryCountObj = {}
    countriesDataUniqueByIP.forEach((obj) => {
      const country = obj.ip_country

      // If the country is encountered for the first time, add it to the uniqueCountries array
      if (!countryCountObj[country]) {
        countryCountObj[country] = 1
      } else {
        // If the country is already in the uniqueCountries array, increment its count
        countryCountObj[country]++
      }
    })

    const countryCountArrOfArrs = Object.entries(countryCountObj)
    const sortedCountryCountArrOfArrs = countryCountArrOfArrs.sort(function(a, b) {
      return b[1] - a[1]
    })

    const firstFiveCountriesArrOfArrs = sortedCountryCountArrOfArrs.slice(0, 5)
    const otherCountriesCount = sortedCountryCountArrOfArrs.slice(5).reduce((partialSum, a) => partialSum + a[1], 0)

    const firstFiveCountriesCounts = firstFiveCountriesArrOfArrs.reduce((arr, val) => arr.concat(val[1]), [])
    const firstFiveCountriesLabels = firstFiveCountriesArrOfArrs.reduce((arr, val) => arr.concat(val[0]), [])

    let data = {
      labels: firstFiveCountriesLabels.concat("Other"),
      datasets: [
        {
          data: firstFiveCountriesCounts.concat(otherCountriesCount),
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
      ]
    }

    return data
  }
  let countriesDataPromise = getCountriesData()

  const options = {
    responsive: true,
    elements: {arc: {borderWidth: 0,}},
    plugins: {
      legend: {
        labels: {
          color: "rgb(170 170 170)"
        },
        position: "right",
      },
    },
    cutout: "70%",
    rotation: 90,
  }
  
  ChartJS.register(Title, Tooltip, Legend, ArcElement, CategoryScale)
</script>

<SwipeWrapper leftLink={leftLink} rightLink={rightLink}>
  <div style="padding: 2rem;">
    <h1>Data</h1>

    <GreyCard>
      <p class="no-margin">This site was written in Svelte by me.<br />You can find the
        <a
          style="color: white"
          href="https://github.com/lu1a/portfolio-site"
          target="_blank"
        >
          source code
        </a>
        on my GitHub.<br />As you'll be able to see there, I have no code for
        cookies or other nasties.
      </p>
    </GreyCard>

    {#await countriesDataPromise}
      <!-- Loading countries data... -->
    {:then data}

      <div>
        <div style="width: 300px;margin-top: -3rem;">
          <Doughnut {data} options={options} />
        </div>
        <p class="no-margin p-over-pure-black" style="margin-top: -3rem;">Countries of unique visitors to this site<br />(via my Golang API → Kafka → Timescale)</p>
      </div>

    {:catch someError}
      System error: {someError.message}.
    {/await}

  </div>

</SwipeWrapper>

<style>
  .no-margin {
    margin: 0;
  }

  .p-over-pure-black {
    color: rgb(132 132 135);
    font-size: 1.2rem;
  }
</style>
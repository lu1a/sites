import { getAllVisitorLogEntries } from '$lib/visitor-log'
import { json } from '@sveltejs/kit'
 
export async function GET() {
  const logEntries = await getAllVisitorLogEntries()

  const key = 'ip_address'
  // @ts-ignore
  const countriesDataUniqueByIP = [...new Map(logEntries.map((item) =>[item[key], item])).values()]

  // ⬇️ Making the unique IP data graphable 

  const countryCountObj = {}
  countriesDataUniqueByIP.forEach((obj) => {
    const country = obj.ip_country
    // @ts-ignore
    if (!countryCountObj[country]) {
      // @ts-ignore
      countryCountObj[country] = 1
    } else {
      // @ts-ignore
      countryCountObj[country]++
    }
  })

  const countryCountArrOfArrs = Object.entries(countryCountObj)
  const sortedCountryCountArrOfArrs = countryCountArrOfArrs.sort(function(a, b) {
    return b[1] - a[1]
  })

  const firstFiveCountriesArrOfArrs = sortedCountryCountArrOfArrs.slice(0, 5)
  const otherCountriesCount = sortedCountryCountArrOfArrs.slice(5).reduce((partialSum, a) => partialSum + a[1], 0)

  // @ts-ignore
  const firstFiveCountriesCounts = firstFiveCountriesArrOfArrs.reduce((arr, val) => arr.concat(val[1]), [])
  // @ts-ignore
  const firstFiveCountriesLabels = firstFiveCountriesArrOfArrs.reduce((arr, val) => arr.concat(val[0]), [])

  return json({
    labels: firstFiveCountriesLabels.concat("Other"),
    data: firstFiveCountriesCounts.concat(otherCountriesCount),
  })
}

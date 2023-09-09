import { getUniqueIPsByCountry } from '$lib/visitorLog'
import { json } from '@sveltejs/kit'
 
export async function GET() {
  const uniqueIPsByCountry = await getUniqueIPsByCountry()

  // Convert the object to an array of arrays containing only values
  // @ts-ignore
  const countryCountArrOfArrs = uniqueIPsByCountry.map((entry) => Object.values(entry))
  // @ts-ignore
  const sortedCountryCountArrOfArrs = countryCountArrOfArrs.sort(function(a, b) {
    return b[1] - a[1]
  })

  const firstFiveCountriesArrOfArrs = sortedCountryCountArrOfArrs.slice(0, 5)
  // @ts-ignore
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

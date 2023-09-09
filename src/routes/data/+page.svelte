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

  // TODO: use real data from tsdb
  let data = {
    labels: ["Finland", "Australia", "Germany", "Other"],
    datasets: [
      {
        data: [79, 4, 1, 16],
        backgroundColor: [
        '#EE2E31',
        '#1D7874',
        '#679289',
        '#F4C095',
      ],
      hoverBackgroundColor: [
        '#EE2E31',
        '#1D7874',
        '#679289',
        '#F4C095',
      ],
      },
    ]
  }

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
      tooltip: {
        enabled: false,
      }
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

    <div>
      <div style="width: 300px;">
        <Doughnut {data} options={options} />
      </div>
      <p class="no-margin p-over-pure-black">Countries of unique visitors to this site<br />(via my Golang API → kakfa → Timescale)</p>
    </div>

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
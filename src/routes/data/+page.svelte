<script>
  // @ts-nocheck

  import { Bar } from 'svelte-chartjs';
  import {
    Chart,
    Title,
    Tooltip,
    Legend,
    BarElement,
    CategoryScale,
    LinearScale,
  } from 'chart.js';

  import SwipeWrapper from "../../components/SwipeWrapper.svelte";
  import GlassCard from '../../components/GlassCard.svelte';

  let leftLink = "/about";
  let rightLink = "/contact";

  // TODO: use real data from tsdb
  let data = {
    labels: ["Finland", "Australia", "Germany", "Other"],
    datasets: [
      {
        data: [79, 4, 1, 16],
        backgroundColor: [
          'white',
          'white',
          'white',
          'white',
        ],
      },
    ]
  };

  const options = {
    animation: false,
    barThickness: 10,
    plugins: {
      legend: {
        display: false,
      },
    },
    responsive: true,
    scales: {
      x: {
        ticks: {
          color: "white",
        },
      },
      y: {
        display: false,
      },
    },
  };
  
  Chart.register(
    Title,
    Tooltip,
    Legend,
    BarElement,
    CategoryScale,
    LinearScale
  );
</script>

<SwipeWrapper leftLink={leftLink} rightLink={rightLink}>
  <div style="padding: 1rem;">
    <h1>Data</h1>

    <div>
      <p class="no-padding">Countries of unique visitors to this site (via my Golang API -> kakfa -> Timescale):</p>
      <br />
      <div style="width: 300px;">
        <Bar {data} options={options} />
      </div>
    </div>

    <div style="display: flex;">
      <p>Note: </p>
      <p style="padding-left: 0.5rem;">This site was written in Svelte by me.<br />You can find the
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
    </div>

  </div>
  
  <GlassCard style="margin-top: -17em;margin-left: 7rem;">
    <p class="no-padding">
     No surprises here...
    </p>
  </GlassCard>

</SwipeWrapper>

<style>
  .no-padding {
    margin: 0;
  }
</style>
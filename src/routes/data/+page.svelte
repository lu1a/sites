<script>
  import { Graphic, RectangleLayer, XAxis, YAxis, x2s } from '@snlab/florence';
  import { scaleLinear, scaleBand } from 'd3-scale';
  import SwipeWrapper from "../../components/SwipeWrapper.svelte";
  import GlassCard from '../../components/GlassCard.svelte';

  let leftLink = "/about";
  let rightLink = "/contact";

  // TODO: use real data from tsdb
  const x = ["Finland", "Australia", "Germany", "Other"];
  const y = [79, 4, 1, 16];
  const scaleX = scaleBand () .domain(x) .padding (0.5);
  const scaleY = scaleLinear () .domain ([0, Math.max(...y) ]);
</script>

<SwipeWrapper leftLink={leftLink} rightLink={rightLink}>
  <div style="padding: 1rem;">
    <h1>Data</h1>

    <div>
      <p class="no-padding">Countries of unique visitors to this site (via my Golang API -> kakfa -> Timescale):</p>
      <div style="margin-left: -1.3rem;">
        <Graphic width={300} height={180} {scaleX} {scaleY} flipY padding={20}>
          <RectangleLayer
            x1={x}
            x2={x2s(x)}
            y1={Array(x.length).fill(0)}
            y2={y}
            fill="white"
          />
          <XAxis baseLineColor="white" labelColor="white" labelFont="Verdana" />
          <YAxis baseLineColor="white" ticks={false} />
        </Graphic>
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
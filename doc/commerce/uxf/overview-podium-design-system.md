---
id: overview-podium
category: a-overview
position: 11
title: Podium Design System
url: /commerce/uxf/overview-podium-design-system.html
---

# Podium Design System Overview

---

## What is it?

Nike's Podium Design System (PDS) provides a scalable, flexible and responsive toolset that is used to standardize the look, feel and functionality of UI elements across Nike experiences. PDS achieves this by offering a comprehensive set of system (UI) components, design tokens and icons. It is recommended that all Nike commerce web and mobile experiences adopt PDS.

**Design system components** can use one or more design tokens to create simple or complex UI elements such as carousels, buttons and images. Components contain several configurable properties that represent HTML attributes.

**Design tokens** represent style values. For example, the web color token named `colorContentPrimary` represents the hex color value `#111111`. They are used by design system components behind the scenes, but you can also use design tokens directly.

**Design system icons** are stored in [Figma](https://www.figma.com/file/WHGv51Q14Zeq8XZ3Y6UIT3/Podium-DS-Icon-Library?node-id=0%3A25){:target="new-tab"}. In addition to the existing icons in the library, you can create your own and submit them as possible additions to the design system icon library.

## Can PDS be used with Web Shell?
Yes! The PDS component, token and icon libraries are automatically accessible in the [Web Shell](https://super-bassoon-778bf849.pages.github.io/){:target="new-tab"} with no special configuration necessary.

The code script below sets the PDS button component using the design token `borderRadius` with a border width of value `sizeBorderWidthS`.

```
import React from "react";
import { ButtonStyled, useTokens } from "@nike/nike-design-system-components";

export default function HomePage() {
  const { sizeBorderWidthS } = useTokens();
  return ({% raw %}
    <div style= {{ borderRadius: sizeBorderWidthS }} >{% endraw %}
      <ButtonStyled>Click Me!</ButtonStyled>
    </div>
  );
}
```

## Where can I find out more?

You can find the PDS component library with cut-and-paste code examples (including Beta) in the [Nike Design System Storybook](https://nike-design-system.s3.amazonaws.com/storybook/production/latest/index.html?path=/story/intro-getting-started--page){:target="new-tab"}. This comprehensive guide also covers the design token library, icon library, v0 to v1 migration, and how to profile React components.

Visit the [NDS Component Demos](https://nike-design-system.s3.amazonaws.com/demos/production/latest/index.html){:target="new-tab"} site to see how the NDS library can be used to create feature-rich functionality such as product carousels, modals, dropdowns and form validation.

Interested in contributing to PDS? See the [InnerSource How to Contribute](hhttps://confluence.nike.com/display/TG/CoreUX+-+InnerSource+How+to+contribute+to+the+Nike+Design+System%3A+Squad+Supports+Contributions){:target="new-tab"} page in Confluence for details.

#### Contacting the Podium Design team:

|---|---|
|Slack|[#podium_design_system](https://nikedigital.slack.com/archives/CK1A5TXQA)|
|Confluence Space|[Podium Design System](https://confluence.nike.com/display/PDS/Podium+Design+System){:target="new-tab"}
|Product Owner|[gayla.hilton@nike.com](mailto:gayla.hilton@nike.com){:target="new-tab"}|

### Connect

The Tech Docs team is here to help with your doc needs. Reach us through &nbsp;<i class="g72-chat"></i> [#Slack](slack://channel?team=T0G3T5X2B&id=C6A18NT7W)&nbsp;&nbsp;&nbsp;<i class="g72-email"></i> [Email](mailto:Lst-nde.docs@nike.com) or click the Provide Feedback button in the lower right corner.
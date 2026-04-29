# mimhoff.com — Astro Site Rebuild Brief (v2)

## Overview

Rebuild mimhoff.com as a researcher-practitioner profile site using Astro. The site should position Matthew Imhoff as someone who works at the intersection of technology, humanitarian impact, and education — not as a delivery manager who volunteers on the side, but as someone building a coherent body of work across practice, research, and leadership.

The site needs to support three long-term career tracks simultaneously:
- **Academia:** PhD → applied research → research centre leadership
- **Policy & Advisory:** government, intergovernmental, NFP boards
- **Builder/Practitioner:** the engineering delivery and innovation projects at Rapido

All three tracks draw on the same foundation: applied technology in humanitarian and social impact contexts. The site should make that thread obvious.

Design tone: clean, professional, warm. Think Brittany Chiang's structure meets Cassidy Williams' personality. Not a corporate CV — a personal site that makes a good first impression on PhD supervisors, conference organisers, IEEE collaborators, policy audiences, Rapido partners, and students alike.

---

## Project Structure

```
mimhoff.com/
├── public/
│   ├── favicon.svg
│   ├── og-image.png              # Social sharing preview image
│   ├── resume.pdf                # Optional downloadable CV
│   └── games/                    # Existing game assets (if self-hosted)
│       ├── wordlock/
│       ├── duck-tictactoe/
│       └── chain-4/
├── src/
│   ├── layouts/
│   │   └── BaseLayout.astro      # HTML shell, meta tags, fonts, global styles
│   ├── components/
│   │   ├── Header.astro          # Name + tagline + nav links
│   │   ├── About.astro           # Bio paragraphs — the core narrative
│   │   ├── Research.astro        # Publications & research interests
│   │   ├── PublicationCard.astro # Individual publication entry
│   │   ├── Work.astro            # Professional roles — practice & leadership
│   │   ├── RoleCard.astro        # Individual role card component
│   │   ├── Projects.astro        # Side projects — games + tools
│   │   ├── ProjectCard.astro     # Individual project card
│   │   ├── Contact.astro         # Social links + email
│   │   └── Footer.astro          # Copyright + colophon
│   ├── pages/
│   │   ├── index.astro           # Single-page home (assembles all components)
│   │   ├── wordlock.astro        # Game page (or redirect to /games/wordlock)
│   │   ├── duck-tictactoe.astro
│   │   └── chain-4.astro
│   └── styles/
│       └── global.css            # Base typography, variables, reset
├── astro.config.mjs
├── package.json
└── tsconfig.json
```

### Changes from v1
- `Speaking.astro` → replaced by `Research.astro` + `PublicationCard.astro` (elevated to named section)
- `Roles.astro` → renamed to `Work.astro` (reframed around career tracks, not org chart)
- Section order changed: Research now sits between About and Work

---

## Page Sections (index.astro)

Section order on the page:

1. Header
2. About
3. Research & Publications
4. Work & Leadership
5. Side Projects
6. Contact / Footer

The rationale for this order: a visitor should understand *who you are and what you think about* (About + Research) before they see *where you work and what you've done* (Work + Projects). This is how academic and policy profiles are structured — identity and ideas first, credentials second.

---

### 1. Header

**Component:** `Header.astro`

```
Matthew Imhoff

Researcher-Practitioner · Humanitarian Technology · Sydney

[About] [Research] [Work] [Projects]                    [LinkedIn] [GitHub] [Email]
```

- Full name as h1
- Tagline positions the research-practice bridge, not job titles
- Nav anchors to each section (left-aligned)
- Social icons (right-aligned)
- The word "researcher-practitioner" is deliberate — it's the term used in engineering education and development studies for someone who generates knowledge from practice. It signals academic intent without overclaiming.

**Tagline alternatives** (pick the one that feels right):

- `Researcher-Practitioner · Humanitarian Technology · Sydney`
- `Technology for humanitarian impact — research, practice, education`
- `Applied research at the intersection of technology and social impact`

### 2. About

**Component:** `About.astro`

Three paragraphs that tell a single story: practice → research → where it's heading. Draft:

> I work at the intersection of technology, humanitarian action, and education. My research interest is in how AI and software systems can be designed and deployed in humanitarian field contexts — not as hypothetical interventions, but as tools shaped by the constraints and realities of community-facing work.
>
> By day, I'm a Technical Delivery Manager at UTS Rapido, a university-embedded R&D hub at the University of Technology Sydney, where I lead software delivery for industry and social impact partners. I also teach Technology Innovation Management at UTS and design internship programs that connect engineering students with real-world project work.
>
> Through IEEE, I chair the Tech4Good program on the Humanitarian Technologies Board, funding grassroots technology projects in underserved communities worldwide. I'm currently establishing an IEEE SIGHT group in New South Wales to build a local community of practice around humanitarian engineering. I hold a background in electrical engineering, mathematics, development studies, and environmental engineering, and I spent eight years at the Australian Centre for Field Robotics at the University of Sydney.

Key design notes:
- Lead with interests and ideas, not job title
- The first paragraph is the thesis statement — what you care about and what you study
- Second paragraph grounds it in current practice
- Third paragraph establishes credibility and institutional depth
- Link key terms: "UTS Rapido" → uts.edu.au/rapido, "Tech4Good" → relevant IEEE page, "SIGHT" → sight.ieee.org, "Australian Centre for Field Robotics" → acfr.usyd.edu.au
- Headshot/avatar recommended here — approachable, not corporate

### 3. Research & Publications

**Component:** `Research.astro` (contains `PublicationCard.astro` instances)

This is a first-class section, not an appendix. It should feel like the research page on an academic's personal site — brief statement of research interests, then publications listed in reverse chronological order.

**Research interests statement** (2–3 sentences above the publication list):

> My research focuses on AI-enabled systems for humanitarian field operations, and on how engineering education can better prepare students for social impact work. I'm particularly interested in the design challenges that arise when technology meets unstructured, resource-constrained, and community-driven environments.

**Publications:**

Each publication entry should include: title (linked if available), author list, venue/publisher, year, status badge, and a one-line plain-language summary.

```
┌─────────────────────────────────────────────────────────────────┐
│  📄 FORTHCOMING                                                 │
│                                                                 │
│  AI-Enabled Voice Automation for Night-Time Street Safety       │
│  Volunteers: A Case Study with Streetkind                       │
│                                                                 │
│  M. Imhoff, [co-authors TBC]                                   │
│  [Conference/venue TBC], 2026                                   │
│                                                                 │
│  Explores how voice-driven AI tools can support volunteers      │
│  working in night-time street outreach — reducing cognitive     │
│  load and improving data capture in unstructured, high-empathy  │
│  field settings.                                                │
├─────────────────────────────────────────────────────────────────┤
│  📄 IN PROGRESS                                                 │
│                                                                 │
│  [Title TBC — IEP / Humanitarian Engineering Education          │
│  & Generative AI book chapter]                                  │
│                                                                 │
│  M. Imhoff, G. Miao, [other co-authors TBC]                    │
│  Book chapter, 2026                                             │
│                                                                 │
│  Examines the role of generative AI as a diagnostic and         │
│  pedagogical tool in a first-year humanitarian engineering      │
│  design subject at UTS.                                         │
└─────────────────────────────────────────────────────────────────┘
```

**Design notes:**
- Status badges: `PUBLISHED`, `FORTHCOMING`, `IN PROGRESS` — styled as small coloured pills
- As papers are accepted and published, update status and add DOI/PDF links
- This section will grow over time — design it so adding a new entry is just adding a new `PublicationCard` component or (better) a new markdown file in an Astro content collection
- The one-line summary beneath each paper is important: it makes the research accessible to non-academic visitors (policy people, industry partners, students)

**Future-proofing:** When the publication list grows beyond 3–4 items, consider splitting into a dedicated `/research` page and showing only the 2–3 most recent on the homepage with a "View all publications →" link.

### 4. Work & Leadership

**Component:** `Work.astro` (contains `RoleCard.astro` instances)

Reframed from the v1 "Roles" section. Instead of three columns by organisation, frame it around the three career tracks. This makes the site legible to different audiences — an academic hiring committee, a policy board, or an engineering team each see their entry point.

**Section intro** (one sentence):

> My work spans applied R&D projects, education, and humanitarian technology leadership.

**Three-column grid:**

```
┌─────────────────────┬─────────────────────┬──────────────────────┐
│ 🔧 Projects         │ 🎓 Education        │ 🌏 Leadership        │
│                     │                     │                      │
│ Technical Delivery  │ Casual Academic     │ IEEE Humanitarian    │
│ Manager             │ UTS                 │ Technologies Board   │
│ UTS Rapido          │                     │                      │
│                     │ • Technology        │ • Chair, Tech4Good   │
│ • R&D delivery for  │   Innovation        │   Program            │
│   industry & social │   Management        │ • Vice-Chair, IEEE   │
│   impact partners   │ • Internship        │   NSW Section        │
│ • AI/ML, data       │   program design    │ • Founder, IEEE      │
│   science, cloud    │ • First-year        │   SIGHT NSW          │
│ • Mentoring junior  │   engineering       │ • IEEE Senior Member │
│   engineers         │   design assessment │ • 20+ years with     │
│                     │                     │   Engineers Without  │
│ Previously:         │                     │   Borders Australia  │
│ Australian Centre   │                     │   (Lifetime          │
│ for Field Robotics  │                     │    Achievement       │
│ (8 years)           │                     │    Award)            │
└─────────────────────┴─────────────────────┴──────────────────────┘
```

**Design notes:**
- Column headers are *tracks*, not organisations — "Projects", "Education", "Leadership"
- The EWB Lifetime Achievement Award is a strong credibility signal for the policy/advisory track — include it
- "Previously: ACFR (8 years)" anchors technical depth without taking up a full entry
- This section answers "what do you actually do?" for each audience

### 5. Side Projects

**Component:** `Projects.astro` (contains `ProjectCard.astro` instances)

Renamed from "Projects" to "Side Projects" to distinguish from the research and professional work above. This is now clearly the fun/personal section.

Grid of project cards. Each card: screenshot/icon, title, one-line description, tech tags, and "Play" or "View" link.

**Games:**

| Project | Description | Tags |
|---------|-------------|------|
| WordLock | Wordle with a strategic twist — each guess locks letters in place | JavaScript, Game Design |
| Duck Tic-Tac-Toe | Classic tic-tac-toe with an AI opponent and a duck blocker mechanic | JavaScript, AI |
| Chain 4 | Get 4 in a row with triangular scoring and cascading combos | JavaScript, Game Design |

**Optional additions:**

| Project | Description | Tags |
|---------|-------------|------|
| Stakeholder Mapping Viz | Interactive Power-Interest Matrix ↔ Rainbow Diagram transformation | D3.js, Project Management |

**Section intro** (one sentence, keeps the tone warm):

> I build browser games in my spare time — mostly as an excuse to think about game mechanics, lateral thinking, and AI opponents.

### 6. Contact / Footer

**Component:** `Contact.astro` + `Footer.astro`

- "Get in touch" with email link
- Row of social icons: LinkedIn, GitHub, Google Scholar (add when publications are indexed), Ko-fi
- Optional: ORCID link (register one before or shortly after launch — you'll need it for the academic track)
- Footer: `© 2026 Matthew Imhoff · Built with Astro`

---

## Technical Decisions

### Styling
- **Tailwind CSS** via `@astrojs/tailwind` integration
- Clean light theme to start (academic/policy audiences expect readability over dark-mode aesthetics)
- Inter typeface (clean, professional, free, widely used)

### Content Collections (new in v2)
Use Astro's content collections for publications so adding a new paper is just dropping a markdown file:

```
src/
└── content/
    └── publications/
        ├── streetkind-voice-automation.md
        └── iep-generative-ai.md
```

Each markdown file has frontmatter:

```yaml
---
title: "AI-Enabled Voice Automation for Night-Time Street Safety Volunteers: A Case Study with Streetkind"
authors: ["M. Imhoff", "TBC"]
venue: "TBC"
year: 2026
status: "forthcoming"  # published | forthcoming | in-progress
summary: "Explores how voice-driven AI tools can support volunteers in night-time street outreach."
doi: ""
pdf: ""
---
```

This means Claude Code builds the rendering logic once, and you just add/edit markdown files as papers progress.

### Games Integration
**Option A — Separate routes (recommended):**
Keep each game as its own page at `/wordlock`, `/duck-tictactoe`, `/chain-4`. Copy existing game HTML/JS/CSS into `public/games/` and load via Astro pages.

### SEO & Social Sharing
In `BaseLayout.astro`:
```html
<title>Matthew Imhoff — Humanitarian Technology Researcher-Practitioner</title>
<meta name="description" content="Researcher-practitioner working at the intersection of AI, humanitarian field operations, and engineering education. Based in Sydney." />
<meta property="og:title" content="Matthew Imhoff" />
<meta property="og:description" content="Humanitarian technology · Applied research · Engineering education" />
<meta property="og:image" content="/og-image.png" />
<link rel="canonical" href="https://mimhoff.com" />
```

Note the shift from v1: the SEO now leads with the research identity, not the job title.

### Deployment
- **Netlify** or **Vercel** (both have free tiers, one-click Astro deploy)
- Connect to GitHub repo for automatic deploys on push
- Custom domain: mimhoff.com

---

## Claude Code Prompting Strategy

Break the build into sequential prompts:

1. **Scaffold:** "Initialise a new Astro project with Tailwind CSS and content collections. Set up the base layout with SEO meta tags and Inter font. Create an index.astro that imports placeholder components for these sections: Header, About, Research, Work, Projects, Contact, Footer."

2. **Header + About:** "Create a Header component with my name, the tagline 'Researcher-Practitioner · Humanitarian Technology · Sydney', nav anchor links to #research, #work, #projects, and social icons for LinkedIn, GitHub, and email. Create an About section with this bio text: [paste bio from Section 2 above]. Style it clean, left-aligned, readable — reference brittanychiang.com for layout."

3. **Research & Publications:** "Create a content collection called 'publications' with markdown files. Each has frontmatter for title, authors, venue, year, status, summary, doi, and pdf. Create a Research component that shows a research interests paragraph followed by publication cards rendered from the collection, sorted by year descending. Each card shows a status badge (colour-coded pill: green for published, amber for forthcoming, grey for in-progress), title, authors, venue, and a plain-language summary. Here are the two publications to add: [paste from Section 3 above]."

4. **Work & Leadership:** "Create a three-column responsive grid with the headers Practice, Education, and Leadership. Each column has a role title, organisation, and bullet points. Here's the content: [paste from Section 4 above]. Stack to single column on mobile."

5. **Side Projects:** "Create a project showcase grid with the section intro 'I build browser games in my spare time...' Each card has a thumbnail placeholder, title, description, tech tags, and a Play link. Here are my projects: [paste from Section 5]. Add subtle hover effects."

6. **Games integration:** "I have three existing browser games built in vanilla JS. Set up routes at /wordlock, /duck-tictactoe, and /chain-4 that load the existing game files from public/games/."

7. **Polish:** "Add smooth scroll behaviour, responsive mobile nav, a subtle scroll-progress indicator, and make sure all external links open in new tabs. Add a Google Scholar icon to the social links row. Ensure the page passes Lighthouse accessibility checks."

8. **Deploy config:** "Add a netlify.toml for deployment. Make sure the build command and publish directory are correct for Astro."

---

## Content Checklist

Before building, prepare these assets:

- [ ] Headshot photo (recommended — approachable, not corporate)
- [ ] Bio text (draft above, refine to your voice)
- [ ] Research interests statement (draft above)
- [ ] Publication details — confirm co-authors and venue for Streetkind paper
- [ ] Publication details — confirm title and co-authors for IEP book chapter
- [ ] Work/leadership descriptions and bullet points
- [ ] Project descriptions and screenshots/icons for each game
- [ ] Social media URLs (LinkedIn, GitHub, Ko-fi, email)
- [ ] ORCID registration (do this before or shortly after launch)
- [ ] Google Scholar profile (set up once first paper is indexed)
- [ ] OG image (1200×630px)
- [ ] Resume/CV PDF (optional — consider an academic CV format)
- [ ] Game source files organised into folders

---

## Notes on Framing

A few strategic points about how this site positions you:

**"Researcher-practitioner" is a specific term.** In engineering education and development studies, it describes someone who generates research knowledge from active professional practice. It's not an overreach — it's accurate for someone writing conference papers drawn from their own field work and delivery experience. It also signals to PhD supervisors that you understand the methodological tradition you'd be entering.

**Research comes before Work on the page.** This is deliberate. For the academic track, a hiring committee or potential supervisor will scan top-down and wants to see your ideas and publications early. For the policy track, showing that you think systematically about the problems you work on is more compelling than a list of job titles. For the practitioner track, the Rapido and IEEE work still appear — they're just contextualised as the practice that feeds the research.

**The Streetkind paper deserves its prominence.** It sits at the exact intersection of your three tracks: AI (technical), humanitarian field operations (social impact), and the methodological question of how you study these things (research). It's not just a publication — it's a thesis statement about the kind of researcher you are.

**The IEP chapter plays a supporting role.** It demonstrates breadth (education research alongside field operations research) and establishes you as someone who publishes in different contexts and with different collaborators.

**The site should grow.** The content collections setup means that as you publish more, present at more conferences, or take on new leadership roles, updating the site is a five-minute markdown edit, not a redesign.

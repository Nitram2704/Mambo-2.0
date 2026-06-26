---
version: "alpha"
name: "Dark Botanical"
description: "Design elegante dark com tipografia Cormorant serif, círculos abstratos e acentos quentes em rosa, ouro e terracota. Premium e sofisticado. Prompt para IA."
colors:
  primary: "#0f0f0f"
  secondary: "#e8e4df"
  tertiary: "#9a9590"
  neutral: "#d4a574"
  surface: "#e8b4b8"
  accent: "#c9b896"
typography:
  h1:
    fontFamily: Cormorant
    fontSize: 2.5rem
    fontWeight: 700
  body-md:
    fontFamily: Cormorant
    fontSize: 1rem
    fontWeight: 400
components:
  button-primary:
    backgroundColor: "{colors.primary}"
    textColor: "{colors.neutral}"
    padding: 12px
---

## Overview

Design elegante dark com tipografia Cormorant serif, círculos abstratos e acentos quentes em rosa, ouro e terracota. Premium e sofisticado. Prompt para IA. Inspirado na estética botânica dark que combina elegância clássica com modernidade. Usa tipografia serif refinada e formas abstratas suaves para criar atmosfera premium e artística, sem recorrer a ilustrações.

- Density: 5/10 — Balanced
- Variance: 8/10 — Expressive
- Motion: 4/10 — Subtle

- **Style:** Elegant, Sophisticated, Artistic, Premium
- **Keywords:** elegant, sophisticated, dark, abstract shapes, soft gradient circles, warm accents, Cormorant serif, IBM Plex Sans, premium, artistic, botanical
- **Era:** 2024-2026 Premium Elegant
- **Light/Dark:** ✗ No / ✓ Full

## Colors

- **Deep Black** (#0f0f0f) — Dark surface, primary background
- **Warm Text** (#e8e4df) — Primary text color
- **Muted Text** (#9a9590) — Primary text color
- **Warm Accent** (#d4a574) — Primary accent, CTAs and interactive elements
- **Soft Pink** (#e8b4b8) — Primary text color
- **Gold** (#c9b896) — Premium accent, decorative highlights
- **Terracotta** (#c4856a) — Extended palette, decorative use

## Typography

- **Display / Hero:** Cormorant — Weight 700, tight tracking, used for headline impact
- **Accent:** IBM Plex Sans — Used for decorative or emphasis text
- **Body:** Cormorant — Weight 400, 16px/1.6 line-height, max 72ch per line
- **UI Labels / Captions:** Cormorant — 0.875rem, weight 500, slight letter-spacing
- **Monospace:** JetBrains Mono — Used for code, metadata, and technical values

Scale:
- Hero: clamp(2.5rem, 5vw, 4rem)
- H1: 2.25rem
- H2: 1.5rem
- Body: 1rem / 1.6
- Small: 0.875rem

## Layout

- **Grid:** CSS Grid primary. Max-width containment: 1280px centered with 1.5rem side padding.
- **Spacing rhythm:** Balanced. Base unit: 0.5rem (8px).
- **Section vertical gaps:** clamp(4rem, 8vw, 8rem).
- **Hero layout:** Asymmetric composition.
- **Feature sections:** Asymmetric grid with varied card sizes. No 3-equal-columns.
- **Mobile collapse:** All multi-column layouts collapse below 768px. No horizontal overflow.
- **z-index contract:** base (0) / sticky-nav (100) / overlay (200) / modal (300) / toast (500).

## Elevation & Depth

Abstract soft gradient circles (blurred, overlapping), warm color accents (pink, gold, terracotta), thin vertical accent lines, italic signature typography, no illustrations only abstract CSS shapes, smooth transitions 350ms

- **Physics:** Ease-out curves, 200-300ms duration. Smooth and predictable.
- **Entry animations:** Fade + translate-Y (16px → 0) over 420ms ease-out. Staggered cascades for lists: 80ms between items.
- **Hover states:** Subtle color shift + shadow adjustment over 200ms.
- **Page transitions:** Fade only (200ms).
- **Performance:** Only transform and opacity animated. No layout-triggering properties.

## Components

- **Primary Button:** Rounded (50%) shape. Accent color fill. Hover: 8% darken + subtle lift shadow. Active: -1px translate tactile press. Font weight 600. No outer glows.
- **Secondary / Ghost Button:** Outline variant. 1.5px border in muted color. Text in primary color. Hover: subtle background fill.
- **Cards:** Rounded (50%) corners. Surface background. Subtle shadow (0 2px 12px rgba(0,0,0,0.06)). 1px border stroke.
- **Inputs:** Label above input. 1px border stroke. Focus ring: 2px accent color offset 2px. Error text below in semantic red. No floating labels.
- **Navigation:** Primary surface background. Active item: accent color indicator. Font weight 500 when active.
- **Skeletons:** Shimmer animation matching component dimensions. No circular spinners.
- **Empty States:** Icon-based composition with descriptive text and action button.

## Do's and Don'ts

- No emojis in UI — use icon system only (Lucide, Heroicons)
- No pure white (#FFFFFF) backgrounds — use off-white or dark surfaces
- No oversaturated accent colors (saturation cap: 80%)
- No 3-column equal-width feature layouts — use zig-zag or asymmetric grid
- No `h-screen` — use `min-h-[100dvh]`
- No AI copywriting clichés: "Elevate", "Seamless", "Unleash", "Next-Gen"
- No broken external image links — use picsum.photos or inline SVG
- No generic lorem ipsum in demos

- Do Cormorant + IBM Plex Sans carregados
- Do Fundo deep black #0f0f0f
- Do Abstract gradient circles CSS
- Do Warm accents (pink
- Do gold
- Do terracotta)
- Do Thin vertical accent lines
- Do Italic signature typography
- Do Sem ilustrações
- Do apenas shapes CSS
- Do Responsivo mobile/tablet/desktop

## Use Case

Marcas de luxo, Joalherias, Spas premium, Galerias de arte, Vinícolas

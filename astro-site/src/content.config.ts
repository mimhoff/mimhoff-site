import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const publications = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/publications' }),
  schema: z.object({
    title: z.string(),
    authors: z.array(z.string()),
    venue: z.string(),
    year: z.number(),
    status: z.enum(['published', 'forthcoming', 'in-progress']),
    summary: z.string(),
    doi: z.string().optional(),
    pdf: z.string().optional(),
  }),
});

export const collections = { publications };

# AIs are changing rapidly, but the default approach is similar

1. **Just fool around with it:** you don't need a tutorial.
2. **Everything is meta:** if you don't know how to use it, ask it.
3. **Aim for persistence:** leave behind instructions and project memory.
4. **Teach it to work more like you.**
5. **Plan, iterate, and show it examples of your work.**

**Six months later:** I would tweak some of the above slightly, but they are all still valid.

<!--
NOTES

- I expected the software to change a lot. It has, mostly in useful ways.
- I am generally very positive about where this is going.
- What I have more to say about now is how humans interact with these tools.
- The interesting questions are increasingly about how to work and what the role of the human is.
-->

---

# Your AI use is a signal for other people

**If you send me unfinished AI work, I learn something about you.**

- Don't be a middleman. If someone needs generic AI output, they can produce it themselves.
- **What is the researcher's added value?**
- The standard of our work has to go up *(brutal but true)*.
- Be transparent about your contributions and AI's contributions.

<!--
NOTES

- Using AI is completely compatible with excellent work. The problem is outsourcing the thinking and passing the result on unfinished.
- Blog example: one-hour conversation with me → Claude-generated blog → sent back to me to review. My ideas went through an unnecessary human middleman.
- That genuinely affects how I think about collaborating with someone.
- Extreme example: Nicholas Polson at Chicago Booth and the recent Andrew Gelman discussion about 258 papers in 2026. AI makes huge quantities of plausible academic output possible; quantity itself is therefore a much weaker signal.
- If producing a first draft becomes almost free, our responsibility for checking, selecting and improving it goes up.
-->

---

# When is it okay to let AI write code?

**Group discussion**

- When you have **100% verification**?
- When you **understand the method**?
- When you **don't care about implementation**?

## Discuss!

<!--
NOTES

- I don't think there is one answer. I want to hear where people draw the line.
- Distinguish understanding the scientific/statistical method from understanding every implementation detail.
- For important research code, my own ideal is still that I can review and understand what the agent has done.
- But there are obviously tasks where implementation matters much less than verification of the output.
-->

---

# Basic workflow with agents

**Terminal → project directory → agent → code / `.md` files / shell**

- Integration across tools is getting better.
- Learn to connect sources of context *(I like Obsidian for this)*.
- Large premium to experimenting — and experimentation is easy.
- For simple work, the limiting factor is often your ability to supervise.

**My current mess:** chat/cloud integrations and terminal agents still do not quite feel like one system.

<!--
NOTES

- The basic workflow has barely changed since March: open a project, launch an agent, let it inspect files and work directly.
- The big improvement is access to the rest of my work: Slack, Drive, Docs, Obsidian, email, papers, GitHub.
- I still haven't unified cloud/chat tools with my local coding-agent workflow.
- One useful workaround: use cloud AI for broad review and critique, then bring the resulting specification into the coding agent. Sometimes I run both in parallel.
- Small workflow improvements compound because they let you supervise more work.
-->

---

# Short demo with BEAR

<!--
NOTES

- Walk through a real project rather than a toy example.
- Show the repository, project context and how I actually launch/work with the agent.
- Keep this short — mainly enough to make the workflow on the previous slide concrete.
-->

---

# What should humans focus on?

**The more context AI gets, the less valuable humans are as conduits for information.**

**Human value increasingly lies in taste, judgement and supervision.**

- **Taste:** What is actually interesting? What is high value?
- **Judgement:** Which objections matter? Which method is appropriate?
- **Supervision:** What should we do next? Did what we just did make sense?

<!--
NOTES

- Humans used to have a huge advantage simply because we knew the project history. That advantage is shrinking.
- AI can now read far more of the project than I remember: papers, notes, conversations, previous analyses.
- Where I still see a clear gap is deciding what matters.
- Statistical example: it can implement many methods perfectly well while still being poor at deciding which method answers the scientific question.
- AI feedback also tends to mix genuinely important issues with nice-to-haves. Somebody still has to prioritise.
-->

---

# Make it behave more like you — transparently

- **Short iteration loops:** agent works → I review → feedback → next task.
- Keep loops short enough that you understand what happened.
- Detailed feedback is cheap: **dictation and stream-of-consciousness instructions work well**.
- **Where do instructions live?**
  - Global config
  - Repo-specific instructions (`AGENTS.md`)
  - Skills

<!--
NOTES

- Transparency is important: I want to inspect the work, understand it, intervene and improve the process.
- When I notice a repeated problem, I don't just fix the current instance — I turn it into an instruction.
- Writing example: reuse terminology already in the manuscript; make minimal edits; don't invent new terminology.
- Style example: "avoid stacked noun modifiers".
- Coding is the same: review the diff, give feedback, and let `AGENTS.md` gradually encode how I want the project written.
- Even if AI writes all the code, for important work I want it written in a way that I can read and review.
- Dictation makes fairly detailed supervision much less tedious.
-->

---

# What am I doing while the agent works?

**We used to do thinking by typing. Now we just need to do thinking.**

- What is worth doing next?
- Are we still answering the scientific question?
- What should go in the paper?
- Is this result plausible or interesting?
- Which rabbit holes are worth pursuing?

<!--
NOTES

- I am not idle while the agent codes. Most of the time I am deciding what it should do next.
- Implementation has become much faster, so I get pushed back into judgement much more frequently.
- I spend more time thinking about what the result means, whether it matters, and how it fits into the paper.
- In that sense, a lot of the job becomes continuously developing and exercising taste.
-->
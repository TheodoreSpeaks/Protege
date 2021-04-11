## Inspiration
The Covid-19 pandemic has disconnected students from educational resources and accelerated the preexisting deficiencies of our K-12 education system. As students reenter schools in person, many are behind on core material from the past 18 months.

According to data analysis done by McKinsey & Co, students only learned 67% of the Math and 87% of the Reading initially assigned over their Spring 2020 semester. The analysis also shows that this skill gap is particularly accentuated in students of color. It is predicted that these Covid-related opportunity gaps will translate into greater achievement gaps in the future among these students.

Simultaneously, classroom sizes have been increasing in the United States. Covid-related state deficits are likely to accelerate these trends and money has been diverted from education to support the Pandemic relief. It is challenging for teachers to help students close these gaps with less time for one-on-one instruction as a result of the increase in students they are responsible for.

We seek to help students catch up fast. Our tool uses GPT-3 AI to help students learn the way we learn best: by teaching others. Students teach AI their assigned concepts in a conversational format to simulate one-on-one instruction helping to address the Covid-19 learning gap. Then AI then summarizes the conversation and reports student performance back to the teacher.

This approach addresses the problem based on education research that supports the value of “Learning by Teaching”. According to one 2005 from the University of Turin, “Learning through teaching involves the presence of a pupil who intervenes in the relationship between oneself and one’s own way of being ... which contributes to the construction of learning itself, being able to activate the processes of observation, listening or experimentation.” (Cortese, 2005) Essentially, the interaction between teacher and pupil causes teachers to solidify their learnings more effectively than even applying the knowledge would. There are tremendous benefits to this pedagogical approach.

These elements of Protégé make it stand out among competing solutions. Traditionally, if a school sought to engage students in a more individualized way, they would have to hire more teachers. Most schools cannot afford to do this, however, and Covid has further compromised the financial state of many schools. Essays are another medium teachers use to gauge student understanding however they are counterintuitive and boring for many students. They also fail to report useful data back to teachers making it more difficult for the medium to impact actual instruction.

`1. Cortese CG. Learning through Teaching. Management Learning. 2005;36(1):87-115. 
doi:10.1177/1350507605049905`
## What it does
As teachers expose students to new concepts and information, they can leverage Protégé as the first step in solidifying student’s understanding of the material. The teacher interface enables them to assign students customized conversations with AI on a wide variety of subjects. From history to mathematics, GPT-3 is a fantastic conversational tool and can be implemented in a wide variety of courses and grades. Teachers have the option to specify how the conversation begins such that the AI starts at the same level of background knowledge before each conversation assignment begins.

When a student begins their assignment, Protégé will initiate a discussion of the recent lesson taught by the teacher. As the student explains what they’ve learned on the topic, the AI actively demonstrates a growing understanding of the new concept through its responses. The assignment ends for the student when they feel they’ve explained the lesson to the best of their ability and that Protégé reflects that knowledge.

As students complete their assignments, GPT-3 will analyze the conversation and summarize what was discussed. We use Spectral Clustering to then sort and group each conversation by depth/accuracy. This is powerful because teachers are able to identify the levels of understanding that students have to further optimize personal instruction.
## How we built it
Protege is built with Flutter, allowing for cross platform compatibility on mobile and desktop alike. We use GPT-3 to be a conversation partner and to summarize the conversation. The GPT3 conversation is then sent to the flask server for analysis. We also use min-hashing to compare responses spectral-analysis to group similar responses to keep the teacher informed on who is understanding core concepts and who needs help. 

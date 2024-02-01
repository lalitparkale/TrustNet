Prototype is envisioned to be a working system, mainly to get the end to end system flow working with all essential plumbing done. Once the end to end flows are working, then aspiration is to seek live feedback from customer research and rapidly update the prototype to deploy and learn.

# AI Usage

To rapidly build, release and iterate at scale, AI will be used as the faithful companion, assistant and a teacher. 

***AI in development***
- Use of Co-pilot for app and core engine development 

***AI for exceptional UX experience***
- edge AI to ensure user data does not leave the mobile device
  
***AI for trustworthy logic execution***
- Post Install - Read contacts, obfuscate, create hash pairs [unique user#, contact#] and send to AI warehouse
- On contacts received - identify service provider numbers from received contacts
- Mine service providers - Go out to the wide internet to mine service provider contacts
- Recommendation (on search) - analyse search text, analyse contacts, apply intelligence and provide top (few) recommended contacts  

***AI in operations***
- <>


# High level building blocks
Simply put, there will be 
1. Engine Room 
2. Mobile App


## 1. Engine Room
EngineRoom will be driven by AI and its associated components and data. EngineRoom will have following broad areas - datastore and intelligent workers.

   **Datastore** will hold entities like   
   1. Contacts
   2. Service Providers
   3. Meta and reference data

   **Intelligent Workers** will be classified as:
   1. Network Builder - this worker class will try to make sense of the contacts, their service provider usage, friends circle depth, influences etc.
   2. Service Provider Miner - this worker class will build a solid registry of service providers. This worker will try to identity categories and sub categories of work/profession. Verify the authenticity, understand professional licenses etc.
   3. Recommendation Adviser - this worker class will provide top trusted contacts for the user's search query
   
![PXL_20240130_085138451](https://github.com/lalitparkale/TrustNet/assets/20618830/fa31adf7-3012-4900-84b8-6e138e373275)

## 2. Mobile App
Mobile App's lifestages will be 
1. Install - Installation will register the users
2. Background Prep - Few events will trigger background preparation. first prep event will be immediately after app installation, which will get contacts, desensitise and post to ***Intelligent Worker***.
3. Active Usage - User will carry out the search for service providers and various other activities. Feedback learner will educate the engine room on user experience and behaviour.
4. Uninstall - Uninstallation will clean all data from the device as well as any refrences available in ***Engine Room***

Aspiration is to utilise Edge AI technology as much as possible so that data stays on the device and never leaves. AI to be utilised for various aspects, like
1. UX enchancer - features to provide exceptional user experience, like auto-fill prediction for search query
2. User Privacy protector - to fill the gaps where Edge AI can't assist, 
![PXL_20240130_085040674](https://github.com/lalitparkale/TrustNet/assets/20618830/8b27e2f7-09f8-4b1f-8203-561642be661c)

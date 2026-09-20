---
title: "Plateful Privacy Policy"
date: 2026-09-20T09:00:00+01:00
draft: false
description: "What Plateful does with your information, in plain words."
layout: "plain"
---


**Last updated: 14 September 2026**

Plateful is a meal planning app for Android. This policy explains, in plain words, what happens to
information when you use it.

Plateful writes your meal plans using an AI model run by Google. That means the details of your request
leave your phone. This policy says exactly what is sent, what comes back, and what stays here.

---

## The short version

- **Your request is sent to Google to write your plan.** How many days and meals, how many people, the
  food you like, the food you cannot eat, what is in your kitchen, and meals you have said yes or no to
  before.
- **Your plans stay on your phone.** The plans, recipes and shopping lists Plateful writes are kept in the
  app's own storage and are not uploaded to us.
- **There is no account and no sign-in.** You never give us a name, an email address or a password.
- **No adverts and no crash reporting.**
- **We measure how the app is used, anonymously** — which options people pick, whether a plan gets saved,
  whether anyone subscribes. Never what you type, and never the foods you cannot eat. See *How we measure
  usage*.
- **If you flag a meal or recipe, that report is sent to us** — see below. It is the only thing you type
  that reaches us, and only when you choose to report something.
- Plateful is asked for permission before anything is sent, the first time you plan.
- If your phone has Google's on-device AI and you lose signal, Plateful writes the plan on the phone
  instead, and says so on the plan.

---

## What is sent when you plan a meal

Each time you ask for a plan or a recipe, Plateful sends Google the details of that request:

- how many days, and which meals of the day
- how many adults and children you are cooking for
- the cuisines you said you like, your diet setting and any time limit
- **the foods you told us you cannot eat**
- anything you listed as already in your kitchen
- the names of meals you have accepted or turned down, so it does not repeat them

This goes to Google's Gemini Developer API through Firebase AI Logic. **We use the paid tier**, under which
Google states that prompts are not used to improve its models. Google's terms govern what they do with it:
<https://ai.google.dev/gemini-api/terms>

We do not receive a copy, and nothing in that request identifies you as a person.

**The can't-eat list is the part we treat most carefully**, because allergies are health information. It is
sent because a plan that ignores it would be dangerous, and for no other reason. It is not stored on our
servers, not logged by us, and not used for anything except writing that plan.

---

## What Plateful stores on your phone

In the app's private storage, which no other app can read:

- The options you choose: days, meal slots, adults and children, cuisines, diet, time limit, the foods you
  cannot eat, and what is already in your kitchen.
- Your plans: the meals suggested, which you accepted or rejected, and the recipes and shopping lists.
- A record of meals you have said yes or no to, so later suggestions fit your taste.
- App settings, such as light or dark mode and which English recipes are written in.
- Anything you report as unsafe or wrong, kept until you choose to send it (see below).

**Backup.** If you have Android backup switched on, Android copies some of this to your own Google Drive.
That means your plans can return to a new phone — and that they are held in your Drive account, under your
control, subject to Google's terms. You can turn it off for Plateful in Android's own settings.

What is copied is a short list rather than everything: your plans, recipes and shopping lists, the record
of what you have said yes and no to, your options, and your app settings. What is not copied is the
anonymous account Plateful signs in with, and the identifiers that measurement uses — those are made fresh
on the new phone, so a backup cannot carry a subscription or make one household look like two.

**Deleting it.** Settings → Your data → Delete everything removes the lot. Uninstalling does the same.
Reports you have already sent are the one exception, because they have left the phone — see *Reporting a
bad recipe*.

---

## If you subscribe

Plateful Plus is sold through Google Play. **We never see your payment details** — Google handles the
purchase and tells us only whether a subscription is valid.

When you subscribe, Plateful:

- creates an **anonymous account** with Firebase, which is a random identifier and nothing else: no name,
  no email address, nothing you typed;
- sends Google Play's purchase token to our server, which asks Google whether it is genuine and current;
- stores, against that random identifier, which product you bought, whether it is active, when it expires,
  and which accounts that purchase has been used on.

That last item exists to stop one subscription being shared endlessly, and holds no personal information.

**Turning it off.** Cancel in Google Play. The record above is deleted when the subscription has been over
for 30 days, or sooner if you ask.

---

## How we measure usage

Plateful uses Google Analytics for Firebase to understand how the app is used, so we can make it better and
work out whether anyone wants to pay for it.

**Only after you agree.** Measurement is switched off until you accept the dialog that explains planning
goes online, and switched off again if you withdraw. Nothing is recorded before that.

**What is recorded:** the options you choose — how many days, which meals, how many people, your diet
setting, the cuisines you tick, the time limit, how involved you want cooking to be — and what you do with
the app: a plan asked for, a meal accepted or turned down, a plan saved, a shopping list opened, the
subscription screen seen, a subscription bought or restored.

**What is never recorded, and cannot be:**

- **The foods you cannot eat.** That is allergy information, and no product question is worth holding it.
  We record only *how many* items are on the list, never what they are.
- **What you say is in your kitchen**, or anything else you type.
- **The names of your meals, your recipes, or anything the AI wrote for you.**

**It is anonymised.** Google Analytics does not log or store IP addresses, we have switched off the parts
that could link it to you, and we have never held a name or an email address to link it to:

- **No advertising ID.** Plateful does not collect the Android advertising identifier, which is the thing
  that would let this data be joined to you across other apps.
- **No advertising use.** The data cannot be used for ad personalisation or shared with advertisers. We
  deny that permanently, not as a setting — Plateful sells a subscription, not attention.
- **No name, email, or account**, because we have never had one to link to.
- **Location only as a country**, never anything finer.

What remains is a **random identifier for this installation**, so that "someone opened a plan and then
saved it" can be told apart from two different people doing one thing each. It is not tied to you, it is
not shared with anyone, and you can clear it whenever you like.

**Turning it off.** Withdraw consent in the app and recording stops. *Settings → Your data → Delete
everything* clears that identifier along with the rest, so what happens afterwards cannot be joined to what
happened before.

## What Plateful does not collect

No name, no email address, no phone number, no precise location, no contacts, no photos, no microphone or
camera access, and no crash reports. Nothing is sold, and nothing is shared with anyone except as
described above.

---

## Reporting a bad recipe

If you flag a meal or recipe, that report is **sent to us**: what was wrong, anything you typed in the
note, and what the AI actually wrote. If you have no signal it waits on your phone and sends itself later.

We ask for this because it is the only way we learn that a recipe was *dangerous* rather than merely
disliked — that a method undercooked chicken, or that something on your can't-eat list got through. Those
reports are what we fix the app with.

**Two things to know before you type in the note.** It is the one place your own words reach us, so please
do not put anything in it you would not want us to read. And the report carries what the AI wrote for your
household, which can reflect the food you told us you cannot eat.

The report holds no name, no email address and no device identifier. It is tied only to the anonymous
random identifier described above. Reports cannot be read back, edited or deleted from the app once sent —
if you want one removed, write to the address at the end of this policy and say roughly when you sent it.

---

## Third parties, stated precisely

We would rather be exact than reassuring, so here is the whole picture.

- **Google (Firebase AI Logic / Gemini Developer API)** receives your plan request and writes the plan.
  Paid tier; Google states prompts are not used to improve its models.
- **Google (Firebase Authentication)** issues the anonymous identifier described above.
- **Google (Cloud Firestore)** stores the subscription record above and the content reports you choose to
  send. Held in London (`europe-west2`).
- **Google (Firebase App Check and Play Integrity)** confirms that requests come from a genuine copy of
  Plateful, so that our AI quota cannot be used by someone else's software. This involves your device
  attesting to Google, not to us.
- **Google Play** handles subscriptions and tells us only whether one is valid.
- **Google's ML Kit**, which Plateful uses for on-device AI, includes a diagnostic component that reports
  its own usage to Google. We cannot disable it and we receive none of it. It reports on the library, not
  on you or your food.
- **Google Analytics for Firebase** records how the app is used, as described above, once you have agreed.
- **Firebase Remote Config** lets us switch online planning off without an app update. It sends us nothing.

There are no other third parties. No advertising networks and no data brokers.

---

## Children

Plateful is not directed at children and we do not knowingly collect anything from them. You can say how
many children you cook for; that is a number, not information about a child.

---

## Your rights

Because we hold no personal information beyond the subscription record above, there is usually nothing to
request. If you believe we hold something about you, or you want the subscription record deleted early,
write to the address below and we will do it.

You can take your data with you at any time regardless: everything Plateful has written is on your phone.

---

## Changes

If this policy changes in a way that affects what leaves your phone, the app will say so before it does
anything different.

---

## Contact

<dhorrocks@gmail.com>

This is the address the app itself uses when you send a report (`SettingsScreen.SUPPORT_EMAIL`), so the two
are always the same. If it ever changes, both change together.

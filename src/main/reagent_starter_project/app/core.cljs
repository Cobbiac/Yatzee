(ns reagent-starter-project.app.core
  (:require [reagent.core :as r]
            [reagent.dom :as rdom]))

(defonce app-state (r/atom {:count 0}))

(defn increase []
  (swap! app-state update :count inc))

(defn decrease []
  (swap! app-state update :count dec))


(defn counter-button [{:keys [on-click label]}]
  [:button.bg-blue-500.rounded-full.w-16.h-16.p-8.flex.justify-center.items-center
   {:type "button"
    :on-click (fn [_] (on-click))}
   [:span.text-4xl.text-white label]])


(defn app []
  [:div.min-h-screen.flex.flex-col.items-center.p-16
   [:h1.text-3xl.font-semibold.mb-8 "Reagent Starter Project"]
   [:div.flex-1.flex.items-center.flex-col.justify-center.gap-4
    [:div.text-3xl "Count: " (get-in @app-state [:count])]
    [:div.flex.flex-row.gap-4
     (counter-button {:on-click decrease :label "-"})
     (counter-button {:on-click increase :label "+"})]]])

(defn render []
  (rdom/render [app] (.getElementById js/document "root")))

(defn ^:export main []
  (render))

(defn ^:dev/after-load reload! []
  (render))


(+ 1 1)
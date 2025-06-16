import React from "react"
import jobData from "../data/jobData.json"
import JobCard from "./JobCard"

const JobAnalysis = () => (
  <div>
    <h2>‰ö‚µ‚¢‹lƒŠƒXƒg</h2>
    {jobData.map((job, i) => <JobCard key={i} data={job} />)}
  </div>
)
export default JobAnalysis

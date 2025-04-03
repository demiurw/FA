"""
Scholarship data model.
"""
import datetime
from dataclasses import dataclass, field
from typing import List, Optional

@dataclass
class Scholarship:
"""Data model for scholarship information."""

    title: str
    description: str
    amount: str
    deadline: str
    source_website: str
    source_name: str

    # Optional fields
    eligibility: Optional[str] = None
    application_link: Optional[str] = None
    application_process: Optional[str] = None
    required_documents: Optional[str] = None

    # Scholarship characteristics
    meritBased: bool = False
    needBased: bool = False
    required_gpa: Optional[float] = None
    categories: List[str] = field(default_factory=list)

    # Timestamps
    scraped_date: str = field(default_factory=lambda: datetime.datetime.now().isoformat())
    last_updated: str = field(default_factory=lambda: datetime.datetime.now().isoformat())

    def to_dict(self) -> dict:
        """
        Convert the scholarship to a dictionary.

        Returns:
            dict: Dictionary representation of the scholarship
        """
        return {
            'title': self.title,
            'description': self.description,
            'amount': self.amount,
            'deadline': self.deadline,
            'source_website': self.source_website,
            'source_name': self.source_name,
            'eligibility': self.eligibility,
            'application_link': self.application_link,
            'application_process': self.application_process,
            'required_documents': self.required_documents,
            'meritBased': self.meritBased,
            'needBased': self.needBased,
            'required_gpa': self.required_gpa,
            'categories': self.categories,
            'scraped_date': self.scraped_date,
            'last_updated': self.last_updated
        }

    @classmethod
    def from_dict(cls, data: dict) -> 'Scholarship':
        """
        Create a Scholarship from a dictionary.

        Args:
            data (dict): Dictionary containing scholarship data

        Returns:
            Scholarship: Scholarship object
        """
        # Filter out any keys that are not valid fields in the dataclass
        valid_fields = {
            'title', 'description', 'amount', 'deadline', 'source_website', 'source_name',
            'eligibility', 'application_link', 'application_process', 'required_documents',
            'meritBased', 'needBased', 'required_gpa', 'categories', 'scraped_date', 'last_updated'
        }

        filtered_data = {k: v for k, v in data.items() if k in valid_fields}
        return cls(**filtered_data)
